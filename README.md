Aria2 with AriaNG
---

### 在docker中运行

**/DOWNLOAD_DIR** 为保存下载文件的目录, **/CONFIG_DIR** 为aria2配置文件目录, **YOUR_SECRET_CODE** 为你自定义的SECRET_CODE

```
sudo docker run -d \
--name aria2-ng \
-p 80:80 \
-p 6800:6800 \
-v /DOWNLOAD_DIR:/data \
-v /CONFIG_DIR:/conf \
-e SECRET=YOUR_SECRET_CODE \
cloudtry/aria2-ng:latest
```