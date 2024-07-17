# Use the official Ubuntu image
FROM ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \ 
    apt install -y curl && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash && \
    apt install -y mysql-server && \
    apt-get install -y python3-pip && \
    apt install -y vim && \
    pip3 install azure-identity azure-keyvault-secrets mysql-connector-python pandas 

# Create a directory for the SSH daemon to run
RUN mkdir /var/run/sshd

# Allow root login with password
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Change SSH port to 80
RUN sed -i 's/#Port 22/Port 80/' /etc/ssh/sshd_config

# Set root password
RUN echo 'root:password' | chpasswd

# Expose port 80 for SSH
EXPOSE 80

# Simply print 
RUN echo "https://github.com/hkhudari/testrepojune17/"

# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]
