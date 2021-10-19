<template>
  <div>
    <v-alert
      max-width="500"
      dismissible
      v-model="showAlert"
      border="top"
      color="red lighten-2"
      dark
    >
      Senha ou Email Inválidos
    </v-alert>
    <v-container>
      <v-form ref="loginForm" @submit.prevent="submit">
        <h1>Login</h1>
        <v-row class="d-flex">
          <v-col cols="12" sm="6">
            <v-text-field
              v-model="form.email"
              :rules="rules.email"
              color="purple darken-2"
              label="Email"
              required
            />
          </v-col>

          <v-col cols="12" sm="6">
            <v-text-field
              v-model="form.password"
              :rules="rules.password"
              color="purple darken-2"
              type="password"
              label="Senha"
              required
            />
          </v-col>
        </v-row>

        <v-btn color="orange" dark type="submit" class="mt-8">
          <span>Login</span>
          <v-icon right>mdi-login-variant</v-icon>
        </v-btn>
      </v-form>
    </v-container>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";

export default {
  name: "Login",
  data() {
    return {
      form: {
        email: "",
        password: "",
      },
      rules: {
        email: [
          (v) => v.length > 8 || "Preencha um email válido",
          (v) => /.+@.+/.test(v) || "Não inventa mano, pôe teu email ai",
        ],
        password: [(v) => v.length >= 4 || "senha inválida"],
      },
      showAlert: false,
    };
  },
  methods: {
    ...mapActions(["login"]),
    async submit() {
      if (this.$refs.loginForm.validate()) {
        await this.login(this.form);
        if (this.isAuth) {
          console.log("hello");
          console.log(this.isAuth);
          this.$router.replace({ name: "Home" });
        }
      } else {
        console.log("hello2");
        this.showAlert = true;
      }
    },
  },
  computed: mapGetters(["isAuth"]),
};
</script>


<style>
.fullscreen {
  height: 100vh;
}
</style>