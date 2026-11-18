# Ứng Dụng Quản Lý Kỷ Luật & Luyện Tập Bóng Đá (Baller Discipline)

> **Học phần:** Phát Triển Ứng Dụng Di Động (PTUDDD)  
> **Nhóm thực hiện:** Nhóm 1 - Lớp 65KTPM  

---

## 1. Giới Thiệu Dự Án
**Baller Discipline** (Football Discipline & Training Tracker) là ứng dụng di động hỗ trợ người chơi bóng đá xây dựng tính kỷ luật, theo dõi tiến độ tập luyện kỹ thuật - thể lực hàng ngày, quản lý thời gian các bài drill và ghi chép nhật ký sau mỗi trận đấu.

---

## 2. Các Phân Hệ Chức Năng Chính
1. **Xác thực & Hồ sơ Cầu thủ (Baller Profile):**
   - Đăng ký, đăng nhập và quản lý tài khoản qua Supabase Auth.
   - Quản lý thông tin cầu thủ: vị trí thi đấu, chân thuận, số áo, câu lạc bộ và ảnh đại diện.
2. **Giáo án Kỷ luật & Chuỗi Tập Luyện (Habits & Streak 🔥):**
   - Danh sách bài tập hàng ngày chia theo 3 nhóm: Kỹ thuật, Thể lực, Dinh dưỡng.
   - Hệ thống tính chuỗi ngày tập liên tục (Streak) tạo động lực duy trì kỷ luật.
3. **Bộ đếm Phiên tập Huấn luyện (Drill Timer & Cloud Log):**
   - Đồng hồ bấm giờ đếm ngược chuyên dụng cho các bài tập (drill) và thời gian nghỉ hiệp.
   - Tự động đồng bộ số phút tập luyện vào cơ sở dữ liệu Supabase.
4. **Nhật ký Trận đấu & Buổi tập (Match Journal & Storage):**
   - Đánh giá phong độ sau trận (rating, bàn thắng, kiến tạo, nhận xét rút kinh nghiệm).
   - Tải và lưu trữ hình ảnh sân đấu lên Supabase Storage.
5. **Thống kê Phong độ & Nhắc lịch Ra sân (Analytics & Notifications):**
   - Biểu đồ khối lượng rèn luyện trực quan và bản đồ nhiệt (heatmap).
   - Hẹn giờ thông báo nhắc nhở lịch tập luyện định kỳ.

---

## 3. Công Nghệ Sử Dụng
- **Framework:** Flutter SDK (`>= 3.0.0`)
- **Ngôn ngữ:** Dart
- **Backend as a Service:** Supabase (Database, Auth, Storage)
- **Thư viện chính:**
  - `fl_chart`: Biểu đồ phân tích thể lực & phong độ
  - `flutter_local_notifications`: Lập lịch thông báo tập luyện

---

## 4. Hướng Dẫn Cài Đặt & Chạy Ứng Dụng
Xem hướng dẫn chi tiết tại tệp [danhsachnhom.md](./danhsachnhom.md).

---

## 5. Quy Chuẩn Làm Việc & Phân Nhánh Nội Bộ
- **Nhánh tích hợp chính của nhóm:** `nhom01-65ktpm`
- **Quy trình đóng góp:**
  1. Thành viên tạo nhánh cá nhân hoặc nhánh tính năng từ `nhom01-65ktpm` (ví dụ: `duchiep`, `feature/...`).
  2. Thực hiện commit các thay đổi trong phạm vi thư mục của nhóm (`nhom1-65ktpm/`).
  3. Đẩy nhánh lên GitHub và tạo **Pull Request** trỏ về nhánh `nhom01-65ktpm` *(tuyệt đối không tạo Pull Request vào nhánh `main`)*.
  4. Trưởng nhóm kiểm tra và hợp nhất (merge) vào nhánh chung của nhóm.

