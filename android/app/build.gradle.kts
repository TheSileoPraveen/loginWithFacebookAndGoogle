plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.facebook_login"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.facebook_login"
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        getByName("debug") {
            // Debug config — no shrinking
            isMinifyEnabled = false
            isShrinkResources = false
        }

        getByName("release") {
            // ✅ Fixed: Disable resource shrinking if minify is false
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    // Required for Flutter
    buildFeatures {
        viewBinding = true
    }
}

dependencies {
    // Kotlin
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.8.10")

    // Android UI
    implementation("com.google.android.material:material:1.9.0")

    // ✅ Firebase
    implementation(platform("com.google.firebase:firebase-bom:32.2.2"))
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-analytics")

    // ✅ Google Sign-In (optional)
    implementation("com.google.android.gms:play-services-auth:20.6.0")

    // ✅ Facebook SDK
    implementation("com.facebook.android:facebook-android-sdk:[15,16)")
}
