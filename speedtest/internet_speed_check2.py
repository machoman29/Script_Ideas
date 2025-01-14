import speedtest
import time

def check_internet_speed():
    try:
        print("Initializing speed test...")
        st = speedtest.Speedtest()  # Initialize the Speedtest object
        print("Finding the best server...")
        st.get_best_server()  # Find the best server based on ping
        print("Best server found. Starting download speed test...")
        
        # Simulate progress for download speed
        for i in range(5):
            print(f"Measuring download speed... step {i+1}/5")
            time.sleep(1)
        dl_speed = st.download() / 1e6  # Download speed in Mbps
        print(f"Download speed measured: {dl_speed:.2f} Mbps")
        
        print("Starting upload speed test...")
        # Simulate progress for upload speed
        for i in range(5):
            print(f"Measuring upload speed... step {i+1}/5")
            time.sleep(1)
        up_speed = st.upload() / 1e6  # Upload speed in Mbps
        print(f"Upload speed measured: {up_speed:.2f} Mbps")
        
        # Final output based on download speed
        if dl_speed > 100:
            print(f"\nYour internet speed is great!\n"
                  f"It is currently at {dl_speed:.2f} Mbps down and {up_speed:.2f} Mbps up.")
        else:
            print(f"\nYour internet speed is below optimal.\n"
                  f"It is currently at {dl_speed:.2f} Mbps down and {up_speed:.2f} Mbps up.")
    
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    print("Starting speed test script...")
    check_internet_speed()
    print("Speed test script finished.")
