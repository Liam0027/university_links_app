<div dir="rtl">

# 🔔 تنظیمات اعلان

</div>

> 🇮🇷 [Persian/فارسی](#فارسی) | 🇬🇧 [English](#english)

---

## English

### Manual Setup Steps

#### 1. AndroidManifest.xml
Path: `android/app/src/main/AndroidManifest.xml`

Add these permissions inside the `<manifest>` tag:

```xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

Add these receivers inside the `<application>` tag:

```xml
<receiver
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver"
    android:exported="false">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED"/>
        <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
        <action android:name="android.intent.action.QUICKBOOT_POWERON"/>
    </intent-filter>
</receiver>

<receiver
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"
    android:exported="false"/>
```

#### 2. build.gradle (app-level)
Path: `android/app/build.gradle`

Make sure `minSdkVersion` is at least **21**:

```gradle
defaultConfig {
    minSdkVersion 21
    // ...
}
```

#### 3. flutter pub get
After adding the packages to `pubspec.yaml`:

```bash
flutter pub get
```

### How the Notification System Works

```
User taps "Saba" or "Samad"
        ↓
Today's date is saved (SharedPreferences)
        ↓
This week's pending notifications are cancelled
        ↓
Starting the following Saturday, a daily reminder fires at 9 AM:
"🍽️ Don't forget to reserve your meal!"
        ↓
This repeats until the user taps the link again
```

### Changing the Notification Time
In `lib/services/notification_service.dart`, find this line:

```dart
9, // 9 AM
```

Change `9` to whatever hour you want (e.g. `11` for 11 AM).

---

<div dir="rtl">

## فارسی

### مراحل تنظیم دستی

#### ۱. فایل AndroidManifest.xml
مسیر: `android/app/src/main/AndroidManifest.xml`

داخل تگ `<manifest>` این مجوزها رو اضافه کن:

```xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

داخل تگ `<application>` هم این receiver ها رو اضافه کن:

```xml
<receiver
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver"
    android:exported="false">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED"/>
        <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
        <action android:name="android.intent.action.QUICKBOOT_POWERON"/>
    </intent-filter>
</receiver>

<receiver
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"
    android:exported="false"/>
```

#### ۲. build.gradle (app-level)
مسیر: `android/app/build.gradle`

مطمئن شو `minSdkVersion` حداقل **21** باشه:

```gradle
defaultConfig {
    minSdkVersion 21
    // ...
}
```

#### ۳. flutter pub get
بعد از اضافه کردن پکیج‌ها در pubspec.yaml:

```bash
flutter pub get
```

### نحوه کار سیستم اعلان

```
کاربر روی «صبا» یا «سماد» تپ می‌کنه
        ↓
تاریخ امروز ذخیره می‌شه (SharedPreferences)
        ↓
اعلان‌های هفته جاری کنسل می‌شن
        ↓
از شنبه هفته بعد، هر روز ساعت ۹ صبح اعلان می‌ده:
"🍽️ رزرو غذا یادت نره!"
        ↓
این چرخه ادامه داره تا کاربر دوباره روی لینک تپ کنه
```

### تغییر ساعت اعلان
در فایل `lib/services/notification_service.dart`، خط زیر رو پیدا کن:

```dart
9, // ساعت ۹ صبح
```

عدد `9` رو به ساعت دلخواه تغییر بده (مثلاً `11` برای ۱۱ صبح).

</div>
