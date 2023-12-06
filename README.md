Setup
===

Temporary
---

`curl https://raw.githubusercontent.com/nodu/defaults/master/basic.sh -o /tmp/basic.sh && source /tmp/basic`

`wget https://raw.githubusercontent.com/nodu/defaults/master/basic.sh -O /tmp/basic.sh && source /tmp/basic`

Permanent
---

```bash
mkdir -p ~/defaults
curl https://raw.githubusercontent.com/nodu/defaults/master/basic.sh -o /defaults/basic.sh
echo 'source ~/defaults/basic.sh' >> ~/.bashrc
```
