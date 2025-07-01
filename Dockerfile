FROM python:3.10

RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    unzip \
    libxml2-dev \
    libgsl-dev \
    libglu1-mesa \
    libx11-6 \
    libxcursor1 \
    libxext6 \
    libxft2 \
    libxinerama1 \
    libxrandr2 \
    libxi6 \
    libgstreamer1.0-0 \
    libgstreamer-plugins-base1.0-0 \
    && rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/Discngine/fpocket.git && \
    cd fpocket && \
    make && \
    make install && \
    cd .. && \
    rm -rf fpocket

WORKDIR /pockets

COPY requirements.txt ./PocketPredict/* /pockets
    
RUN pip install -r requirements.txt

# Download classification model from the provided OneDrive
ADD https://iiitaphyd-my.sharepoint.com/personal/rishal_aggarwal_alumni_iiit_ac_in/_layouts/15/download.aspx?UniqueId=c9384107-f300-4b68-9613-dc7213336f64 /pockets/first_model_fold1_best_test_auc_85001.pth.tar

# Download segmentation model from the provided OneDrive
ADD https://iiitaphyd-my.sharepoint.com/personal/rishal_aggarwal_alumni_iiit_ac_in/_layouts/15/download.aspx?UniqueId=52b48f05-0219-46d9-99e8-edc6635cc103 /pockets/seg0_best_test_IOU_91.pth.tar

WORKDIR /home
