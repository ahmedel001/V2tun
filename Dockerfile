FROM alpine:latest

# تثبيت الحزم اللازمة وتشغيل Xray
RUN apk add --no-cache curl unzip

# تحميل وتشغيل نواة Xray
RUN LATEST_VERSION=$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/${LATEST_VERSION}/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    rm /tmp/xray.zip

# نسخ ملف الإعدادات
COPY config.json /etc/xray/config.json

# تشغيل Xray بالمنفذ المطلوب من Render
CMD ["xray", "-config", "/etc/xray/config.json"]
