import org.gradle.api.file.Directory
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Relocate builds to the project root /build to match Flutter tooling expectations
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    project.evaluationDependsOn(":app")
    // Kotlin incremental compilation control is handled via gradle.properties.
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
