# README.md

## 介绍
文档工具使用mkdocs

## 本地安装
```shell
pip install mkdocs
pip install mkdocs-material

```
## 本地启动调试
```shell
 mkdocs serve
```

## windows环境下建议使用conda隔离

在环境/激活conda环境，然后执行上面的命令

参考如下：

```shell
conda create --name mydocs python=3.8
conda activate mydocs
 mkdocs serve -a localhost:18888

```