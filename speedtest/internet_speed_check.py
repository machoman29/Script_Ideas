import speedtest
#test
def check_internet_speed():
    st = speedtest.Speedtest()
    st.get_best_server()
    dl_speed = st.download() / 1e6  # Convert to Mbps
    up_speed = st.upload() / 1e6    # Convert to Mbps

    if dl_speed > 100:
        print(f"Your internet speed is great!\nIt is currently at {dl_speed:.2f} Mbps down and {up_speed:.2f} Mbps up.")
    else:
        print(f"Your internet speed is below optimal.\nIt is currently at {dl_speed:.2f} Mbps down and {up_speed:.2f} Mbps up.")

if __name__ == "__main__":
    check_internet_speed()
