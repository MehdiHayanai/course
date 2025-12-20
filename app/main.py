from httpx import Client
import streamlit as st

# --- App Layout ---
st.set_page_config(page_title="Fun Image Generator", page_icon="🐶")

st.title("🎉 The Daily Dose of Fun")
st.write("Click the button below to see a random good boy (or girl)!")

if "client" not in st.session_state:
    st.session_state["client"] = Client()


def get_fun_image():
    """Fetches a random dog image URL from the Dog CEO API."""
    try:
        response = st.session_state["client"].get(
            "https://dog.ceo/api/breeds/image/random"
        )
        data = response.json()
        return data["message"]
    except Exception as _:
        return None


# Add a button to fetch a new image
if st.button("✨ Show me a new image ✨"):
    # Show balloons for extra fun
    st.balloons()

    # clear previous cache/state if necessary (Streamlit handles reruns automatically on interaction)
    pass

# Fetch and display the image
image_url = get_fun_image()

if image_url:
    st.image(image_url, caption="Random Cute Doggo", width="stretch")
else:
    st.error("Oops! Couldn't load the fun image. The API might be down.")

st.markdown("---")
st.caption("Powered by Streamlit and the Dog CEO API")
