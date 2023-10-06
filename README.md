

screen -S keeplive
./cpu_consume-linux-amd64 > /dev/null

###	运行程序
```bash
# 前台运行程序
./cpu_consume-linux-amd64

# 前台运行需要一直开着终端窗口，可以在 Screen 中运行程序，以实现断开终端窗口后一直运行。
# 创建 Screen 终端
screen -S cpu_consume
# 在 Screen 中运行程序
./cpu_consume
# 离开 Screen 终端
按下 Ctrl 键不松，依次按字母 A 键和 D 键。或者直接关闭终端窗口也可以。
# 查看已创建的 Screen 终端
screen -ls
# 重新连接 Screen 终端
screen -r cpu_consume

```