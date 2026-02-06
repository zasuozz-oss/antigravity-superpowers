# antigravity-agent
1️⃣ Mỗi ngày vào làm (BẮT BUỘC)
git checkout master
git pull --rebase
➡️ Đảm bảo local luôn mới nhất trước khi sửa
2️⃣ Kiểm tra trạng thái trước khi commit
git status
3️⃣ Stage đúng phần cần push
Push toàn bộ thay đổi
git add .
Chỉ push .agent
git add .agent
4️⃣ Commit
git commit -m "chore(agent): update rules"
Commit message ngắn, rõ, 1 mục đích
5️⃣ Push thẳng lên master
git push origin master
⚠️ Nếu push bị từ chối (remote mới hơn)
git pull --rebase
git push origin master