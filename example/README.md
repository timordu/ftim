# ftim_example

Demonstrates how to use the ftim plugin.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

SDKAppID:1400302303

密钥:8c09a0036de86e671a4727c364780142573e617299d0395f1c98c8988f38eabc

adb 查看指定Tag日志:

adb logcat -b all time -s FtimPlugin:D

json_serializable序列化命令:

flutter packages pub run build_runner build --delete-conflicting-outputs