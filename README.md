<h1 align="center">Welcome to inception_of_things 👋</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0-blue.svg?cacheSeconds=2592000" />
</p>

> IoT is a gateway to mastering Kubernetes through hands-on experience with Vagrant, K3s, and K3d, simplifying the world of container orchestration.

## 📝 Table of Contents

- [⛔️ Warning](#-warning)
- [📋 Prerequisites](#-prerequisites)
- [🔧 Install](#-install)
- [🚀 Usage](#-usage)

## ⛔️ Warning

The sharing of this project on my GitHub aims to help peoples to open their minds to new logics or help peoples in case of difficulty. In no way, that aims to copy and paste this work on your own repository.


## 📋 Prerequisites

- Vagrant `v2.3.7`
- k3d `v5.6.0`
- k3s `v1.27.5-k3s1`
- docker.io

On x86_64 architecture :
- virtualbox `>= 6.1`

On Apple Silicon / ARM architecture :
- VMWare Fusion `13.0.2`

## 🔧 Install

```sh
$ git clone https://github.com/mathias-mrsn/inception_of_things.git
```

## 🚀 Usage

For parts p1 and p2:
```sh
$ cd inception_of_things/...
$ vagrant up
```

For part p3:
```sh
$ cd inception_of_things/...
$ make
``````

For bonus :
```sh
$ cd inception_of_things/.../scripts
$ sh test <HOST_IP>
```

## 👥 Authors

👤 **mamaurai**
* Github: [@mathias-mrsn](https://github.com/mathias-mrsn)
* LinkedIn: [@Mathias MAURAISIN](https://www.linkedin.com/in/mathias-mauraisin)

---

👤 **xchalle**
* Github: [@xchalle](https://github.com/xchalle)



***
_This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)_
