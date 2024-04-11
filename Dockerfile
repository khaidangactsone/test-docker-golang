# Sử dụng hình ảnh golang chính thức làm hình ảnh cơ sở
FROM golang:1.20.4 as builder

# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Sao chép mã nguồn Go vào thư mục làm việc trong container
COPY . .

# Tải về và cài đặt các phụ thuộc (nếu có)
RUN go mod download

# Biên dịch chương trình Go thành tệp thực thi
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o myapp .

# Sử dụng hình ảnh scratch để tạo một hình ảnh nhẹ
FROM scratch

# Sao chép tệp thực thi từ bước xây dựng trước
COPY --from=builder /app/myapp .

# Chạy ứng dụng Go khi container được khởi động
CMD ["./myapp"]
