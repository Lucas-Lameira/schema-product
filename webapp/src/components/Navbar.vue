<template>
  <nav>
    <v-toolbar>
      <v-toolbar-title>
        <span class="orange--text font-weight-bold">APP</span>
        <span class="font-weight-medium">roduct</span>
      </v-toolbar-title>

      <v-spacer></v-spacer>

      <div>
        <v-tabs>
          <v-tabs-slider color="orange"></v-tabs-slider>
          <v-tab
            v-for="route in routes"
            :key="route.name"
            :to="route.route"
            exact
            class="black--text font-weight-medium"
          >
            {{ route.name }}
          </v-tab>
        </v-tabs>
      </div>

      <v-spacer></v-spacer>

      <v-btn class="orange white--text" @click="signout">
        <span>Sign out</span>
        <v-icon right>mdi-export</v-icon>
      </v-btn>
    </v-toolbar>
  </nav>
</template>

<script>
export default {
  data() {
    return {
      routes: [
        { route: "/home", name: "Home" },
        { route: "/products", name: "Products" },
        { route: "/sales", name: "Sales" },
        { route: "/purchases", name: "Purchase" },
        { route: "/about", name: "About" },
      ],
    };
  },
  methods: {
    signout() {
      //remover do localstorage
      localStorage.removeItem("userId");

      // resetar o estado do usuário

      // mover para a página de login
      this.$router.push("/login");
    },
  },
};
</script>