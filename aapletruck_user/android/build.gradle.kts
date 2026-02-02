import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

// ===============================
// BUILD SCRIPT (REQUIRED FOR FIREBASE)
// ===============================
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // 🔥 Firebase Google Services plugin
        classpath("com.google.gms:google-services:4.4.2")
    }
}

// ===============================
// ALL PROJECTS REPOSITORIES
// ===============================
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ===============================
// CUSTOM BUILD DIRECTORY (FLUTTER STYLE)
// ===============================
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

// ===============================
// SUBPROJECTS CONFIG
// ===============================
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// ===============================
// CLEAN TASK
// ===============================
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
