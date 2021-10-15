<template>
  <v-dialog v-model="dialog" persistent max-width="390">
    <template v-slot:activator="{ on, attrs }">
      <v-btn color="orange" v-bind="attrs" v-on="on" icon>
        <v-icon>mdi-trash-can</v-icon>
      </v-btn>
    </template>

    <v-card>
      <v-card-title class="text-h6"> Quer deletar este produto? </v-card-title>

      <v-card-text class="mx-0">
        <p
          class="text-h5 text--primary text-capitalize font-weight-medium mb-2"
        >
          {{ product[1] }}
        </p>

        <span> Estoque:{{ product[2] }}</span>
        <div class="text--primary">R$: {{ product[3] }}</div>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="green darken-1" text @click="dialog = false"> Não </v-btn>
        <v-btn color="green darken-1" text @click="remove(product)">
          Sim
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>


<script>
import { mapActions } from "vuex";
export default {
  name: "DeleteDialog",
  props: ["product"],
  data() {
    return {
      dialog: false,
    };
  },
  methods: {
    ...mapActions(["deleteProduct"]),
    remove(product) {
      let productId = product[0];
      this.deleteProduct(productId);
      this.dialog = false;
    },
  },
};
</script>