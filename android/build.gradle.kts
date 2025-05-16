buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        add("classpath", "com.android.tools.build:gradle:8.6.0")
        // Add more classpath dependencies here if needed
    }
}


allprojects {
    repositories {
        google()
        mavenCentral()
    }
   

}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
