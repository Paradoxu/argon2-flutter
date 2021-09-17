package me.leoletto.plugins.argon2_flutter

import com.lambdapioneer.argon2kt.Argon2Mode
import com.lambdapioneer.argon2kt.Argon2Version

data class HashParams(
    val pass: String,
    val salt: String,

    /// the number of iterations
    val iterations: Int,

    /// used memory, in KiB
    val memory: Int,

    /// desired hash length
    val hashLen: Int,

    /// desired parallelism (it won't be computed in parallel, however)
    val parallelism: Int,

    val mode: Argon2Mode,
    val version: Argon2Version
)
