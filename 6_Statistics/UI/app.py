import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from dotenv import load_dotenv
import os

# LangChain imports
from langchain_core.prompts import PromptTemplate
from langchain_groq import ChatGroq

# Load environment variables
load_dotenv()

# Page config
st.set_page_config(page_title="Blinkit Delivery Analysis", page_icon="📊", layout="centered")

# Title and description
st.title("📊 Blinkit Delivery Time Analysis")
st.markdown("Enter delivery times (in minutes) to analyze performance and get insights.")

# Sidebar for API Key (fallback)
st.sidebar.header("🔑 API Settings")
api_key_input = st.sidebar.text_input("Groq API Key (optional if in .env)", type="password", value="")

# Get API Key
GROQ_API_KEY = api_key_input or os.getenv("GROQ_API_KEY")

# Data Input Section
st.subheader(" Enter Delivery Times")
input_data = st.text_area(
    "Paste comma-separated delivery times (in minutes):",
    placeholder="Example: 15, 22, 18, 30, 25, 20, 35, 28, 19, 24",
    height=100
)

# Process button
if st.button(" Analyze Data", type="primary"):
    if not input_data.strip():
        st.error("Please enter some delivery times!")
    else:
        try:
            # Parse input data
            delivery_times = [float(x.strip()) for x in input_data.split(",") if x.strip()]

            if len(delivery_times) < 2:
                st.error("Please enter at least 2 values for meaningful analysis.")
            else:
                # Convert to numpy array for calculations
                data = np.array(delivery_times)

                # Calculate Statistics
                mean_val = np.mean(data)
                min_val = np.min(data)
                max_val = np.max(data)
                range_val = max_val - min_val
                variance_val = np.var(data, ddof=0)  # Population variance
                std_val = np.std(data, ddof=0)       # Population standard deviation
                count = len(data)

                # Display Metrics in a nice row
                st.subheader("📈 Key Statistics")

                col1, col2, col3, col4 = st.columns(4)
                with col1:
                    st.metric("Total Deliveries", f"{count}")
                with col2:
                    st.metric("Mean Time", f"{mean_val:.2f} min")
                with col3:
                    st.metric("Range", f"{range_val:.2f} min")
                with col4:
                    st.metric("Std Deviation", f"{std_val:.2f} min")

                # Detailed stats table
                st.subheader("📋 Detailed Statistics")
                stats_df = pd.DataFrame({
                    "Statistic": ["Count", "Mean", "Minimum", "Maximum", "Range", "Variance", "Standard Deviation"],
                    "Value": [count, f"{mean_val:.2f}", f"{min_val:.2f}", f"{max_val:.2f}", 
                              f"{range_val:.2f}", f"{variance_val:.2f}", f"{std_val:.2f}"],
                    "Unit": ["deliveries", "minutes", "minutes", "minutes", "minutes", "min²", "minutes"]
                })
                st.table(stats_df)

                # Visualization - Histogram
                st.subheader(" Delivery Time Distribution")

                fig, ax = plt.subplots(figsize=(10, 5))
                ax.hist(data, bins=10, color="#FF6B6B", edgecolor="white", alpha=0.8)
                ax.axvline(mean_val, color="#4ECDC4", linestyle="--", linewidth=2, label=f"Mean: {mean_val:.1f} min")
                ax.set_xlabel("Delivery Time (minutes)", fontsize=12)
                ax.set_ylabel("Frequency", fontsize=12)
                ax.set_title("Histogram of Delivery Times", fontsize=14, fontweight="bold")
                ax.legend()
                ax.grid(axis="y", alpha=0.3)
                st.pyplot(fig)

                # Raw data view
                with st.expander("👀 View Raw Data"):
                    st.write(delivery_times)

                # LangChain AI Explanation
                st.subheader("🤖 AI-Powered Business Insight")

                if not GROQ_API_KEY:
                    st.warning("⚠️ No Groq API Key found. Add it to your `.env` file or enter it in the sidebar to get AI insights.")
                else:
                    with st.spinner("Generating business insight..."):
                        try:
                            # Initialize Groq LLM
                            llm = ChatGroq(
                                groq_api_key=GROQ_API_KEY,
                                model_name="llama-3.1-8b-instant",
                                temperature=0.3
                            )

                            # Create Prompt Template
                            template = """
                            You are a business analyst explaining delivery performance to Blinkit managers 
                            who are not familiar with statistics. Keep it simple, friendly, and actionable.

                            Here are the delivery statistics:
                            - Total Deliveries: {count}
                            - Average Delivery Time: {mean:.2f} minutes
                            - Fastest Delivery: {min_val:.2f} minutes
                            - Slowest Delivery: {max_val:.2f} minutes
                            - Range (spread): {range_val:.2f} minutes
                            - Variance: {variance:.2f}
                            - Standard Deviation: {std:.2f} minutes

                            Please explain what these numbers mean for the business in 3-4 short bullet points.
                            Focus on:
                            1. What the average tells us about customer experience
                            2. What the range/standard deviation tells us about consistency
                            3. One practical recommendation for the operations team

                            Use simple language. Avoid statistical jargon.
                            """

                            prompt = PromptTemplate(
                                input_variables=["count", "mean", "min_val", "max_val", "range_val", "variance", "std"],
                                template=template
                            )

                            # Format the prompt
                            formatted_prompt = prompt.format(
                                count=count,
                                mean=mean_val,
                                min_val=min_val,
                                max_val=max_val,
                                range_val=range_val,
                                variance=variance_val,
                                std=std_val
                            )

                            # Get response from LLM
                            response = llm.invoke(formatted_prompt)

                            # Display the insight
                            st.success(response.content)

                        except Exception as e:
                            st.error(f"Error generating insight: {str(e)}")
                            st.info("Tip: Make sure your Groq API key is valid and you have internet connectivity.")

        except ValueError:
            st.error("Invalid input! Please enter only numbers separated by commas.")
        except Exception as e:
            st.error(f"Something went wrong: {str(e)}")

# Footer
st.markdown("---")
st.markdown("<center>Made with  for Blinkit Operations Team</center>", unsafe_allow_html=True)
