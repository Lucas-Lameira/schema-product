<template>
  <div>
    <v-alert
      dismissible
      v-model="showAlert"
      border="top"
      color="red lighten-2"
      dark
    >
      Senha ou Email Inválidos
    </v-alert>
    <h1>Login</h1>
    <v-form ref="loginForm" @submit.prevent="submit">
      <v-container>
        <v-row>
          <v-col cols="12" sm="6">
            <v-text-field
              v-model="form.userEmail"
              :rules="rules.email"
              color="purple darken-2"
              label="Email"
              required
            />
          </v-col>

          <v-col cols="12" sm="6">
            <v-text-field
              v-model="form.userPassword"
              :rules="rules.password"
              color="purple darken-2"
              type="password"
              label="Senha"
              required
            />
          </v-col>
        </v-row>

        <v-btn text color="primary" type="submit"> Login </v-btn>
      </v-container>
    </v-form>
  </div>
</template>

<script>
import api from "../services/api";

import store from "@vue/cli-plugin-vuex";

export default {
  name: "Login",
  data() {
    return {
      form: {
        userEmail: "",
        userPassword: "",
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
    async submit() {
      if (this.$refs.loginForm.validate()) {
        try {
          const result = await api.post("/login", this.form);

          const user = result.data;
          console.log(result);

          localStorage.setItem("userId", user[0]);

          console.log(user[0]);

          //store user in the vuex store
          /*  this.$store.dispatch('action store function') */

          // redirect user to home
          this.$router.push("/home");
        } catch (error) {
          console.log(error);
          this.showAlert = true;
        }
      } else {
        this.showAlert = true;
      }
    },
  },
};
</script>


<style>
.fullscreen {
  height: 100vh;
}
</style>