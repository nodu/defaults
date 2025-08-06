# Setup

## Temporary

`curl https://raw.githubusercontent.com/nodu/defaults/master/basic.sh -o /tmp/basic.sh && source /tmp/basic.sh`
`curl https://raw.githubusercontent.com/nodu/defaults/master/network.sh -o /tmp/network.sh && source /tmp/network.sh`
`curl https://raw.githubusercontent.com/nodu/defaults/master/git.sh -o /tmp/git.sh && source /tmp/git.sh`

`wget https://raw.githubusercontent.com/nodu/defaults/master/basic.sh -O /tmp/basic.sh && source /tmp/basic.sh`

## Permanent

```bash
mkdir -p ~/defaults
curl https://raw.githubusercontent.com/nodu/defaults/master/basic.sh -o /defaults/basic.sh
curl https://raw.githubusercontent.com/nodu/defaults/master/network.sh -o /defaults/network.sh
curl https://raw.githubusercontent.com/nodu/defaults/master/git.sh -o /defaults/git.sh
echo 'source ~/defaults/basic.sh' >> ~/.bashrc
echo 'source ~/defaults/network.sh' >> ~/.bashrc
echo 'source ~/defaults/git.sh' >> ~/.bashrc
```
