package me.leoletto.plugins.argon2_flutter

import com.lambdapioneer.argon2kt.Argon2Kt
import com.lambdapioneer.argon2kt.Argon2KtResult
import com.lambdapioneer.argon2kt.Argon2Mode
import com.lambdapioneer.argon2kt.Argon2Version

class Argon2Handler {
    val argon2Kt = Argon2Kt()

    fun hash(params: HashParams): Argon2KtResult {
        return argon2Kt.hash(
            params.mode,
            params.pass.toByteArray(),
            params.salt.toByteArray(),
            params.iterations,
            params.memory,
            params.parallelism,
            params.hashLen,
            params.version
        )
    }

    fun mapModeToType(mode: Any?): Argon2Mode {
        return when (mode){
            "Argon2d" -> Argon2Mode.ARGON2_D
            "Argon2i" -> Argon2Mode.ARGON2_I
            "Argon2id" -> Argon2Mode.ARGON2_ID
            else -> Argon2Mode.ARGON2_D
        }
    }

    fun mapModeToVersion(version: Any?): Argon2Version{
        return when (version){
            "V10" -> Argon2Version.V10
            "V13" -> Argon2Version.V13
            else -> Argon2Version.V13
        }
    }
}