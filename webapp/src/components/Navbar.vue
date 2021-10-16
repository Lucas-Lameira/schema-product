<template>
  <nav>
    <v-toolbar>
      <!-- logo -->
      <v-toolbar-title>
        <span class="orange--text font-weight-bold">APP</span>
        <span class="font-weight-medium">roduct</span>
      </v-toolbar-title>

      <v-spacer></v-spacer>

      <!-- menu tabs for navigation -->
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

      <Cart />

      <!-- dropdown menu -->
      <v-menu offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-btn class="orange white--text" v-bind="attrs" v-on="on">
            <span>Lucas lameira</span>
            <v-icon right>mdi-menu-down-outline</v-icon>
          </v-btn>
        </template>
        <v-list>
          <v-list-item v-for="(item, index) in items" :key="index">
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-toolbar>
  </nav>
</template>

<script>
import Cart from "./Cart.vue";

export default {
  name: "Navbar",
  components: {
    Cart,
  },
  data() {
    return {
      routes: [
        { route: "/home", name: "Home" },
        { route: "/products", name: "Products" },
        { route: "/sales", name: "Sales" },
        { route: "/purchases", name: "Purchase" },
        { route: "/about", name: "About" },
      ],
      items: [
        { title: "Click Me" },
        { title: "Click Me" },
        { title: "Click Me" },
        { title: "Click Me 2" },
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