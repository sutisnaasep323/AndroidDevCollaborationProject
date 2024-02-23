import java.util.HashMap

class User(val username: String, val password: String)

class AuthManager {
    private val usersDatabase = HashMap<String, User>()

    fun signUp(username: String, password: String): Boolean {
        if (!usersDatabase.containsKey(username)) {
            val newUser = User(username, password)
            usersDatabase[username] = newUser
            return true
        }
        return false
    }

    fun login(username: String, password: String): Boolean {
        val user = usersDatabase[username]
        return user != null && user.password == password
    }

    fun getUserByUsername(username: String): User? {
        return usersDatabase[username]
    }
}

fun main() {
    val authManager = AuthManager()
    var currentUser: User? = null

    while (true) {
        println("===== Home Menu =====")
        println("1. Sign Up")
        println("2. Login")
        println("3. Home")
        println("4. Search User")
        println("5. Exit")
        print("Pilih menu: ")

        when (readLine()?.toIntOrNull()) {
            1 -> {
                print("Masukkan username: ")
                val signUpUsername = readLine() ?: ""
                print("Masukkan password: ")
                val signUpPassword = readLine() ?: ""

                val signUpResult = authManager.signUp(signUpUsername, signUpPassword)
                if (signUpResult) {
                    println("Sign up successful. Silakan login.")
                } else {
                    println("Username sudah ada. Silakan pilih username lain.")
                }
            }
            2 -> {
                print("Masukkan username: ")
                val loginUsername = readLine() ?: ""
                print("Masukkan password: ")
                val loginPassword = readLine() ?: ""

                val loginResult = authManager.login(loginUsername, loginPassword)
                if (loginResult) {
                    currentUser = authManager.getUserByUsername(loginUsername)
                    println("Login successful. Selamat datang, ${currentUser?.username}!")
                } else {
                    println("Login failed. Username atau password salah.")
                }
            }
            3 -> {
                if (currentUser != null) {
                    println("===== Home Page =====")
                    println("Selamat datang, ${currentUser.username}!")
                } else {
                    println("Anda belum login. Silakan login terlebih dahulu.")
                }
            }
            4 -> {
                print("Masukkan username yang ingin dicari: ")
                val searchUsername = readLine() ?: ""
                val searchedUser = authManager.getUserByUsername(searchUsername)
                if (searchedUser != null) {
                    println("User ditemukan:")
                    println("Username: ${searchedUser.username}")
                } else {
                    println("User tidak ditemukan.")
                }
            }
            5 -> {
                println("Terima kasih! Sampai jumpa lagi.")
                break
            }
            else -> {
                println("Pilihan tidak valid. Silakan pilih kembali.")
            }
        }
    }
}
