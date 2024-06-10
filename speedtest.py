import speedtest
import time
import logging

# This script uses the speedtest-cli library to check the download and upload speed of your network connection.

# Set up logging
logging.basicConfig(filename='network_performance.log', level=logging.INFO, format='%(asctime)s %(message)s')

def check_speed():
    st = speedtest.Speedtest()
    st.download()
    st.upload()
    results = st.results.dict()
    download_speed = results['download'] / 1_000_000  # Convert to Mbps
    upload_speed = results['upload'] / 1_000_000  # Convert to Mbps
    ping = results['ping']
    logging.info(f"Download: {download_speed:.2f} Mbps, Upload: {upload_speed:.2f} Mbps, Ping: {ping} ms")
    print(f"Download: {download_speed:.2f} Mbps, Upload: {upload_speed:.2f} Mbps, Ping: {ping} ms")

# Check speed every hour
while True:
    check_speed()
    time.sleep(3600)
