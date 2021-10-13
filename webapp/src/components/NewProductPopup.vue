<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          v-show="!hidden"
          color="orange"
          dark
          absolute
          bottom
          right
          fab
          fixed
          class="mb-16 mr-16"
          v-bind="attrs"
          v-on="on"
        >
          <v-icon>mdi-plus</v-icon>
        </v-btn>
      </template>

      <v-card>
        <v-card-title>
          <span class="text-h5">Cadastrar Produto</span>
        </v-card-title>

        <v-card-text>
          <v-form ref="newProductForm">
            <v-container>
              <v-row>
                <v-col cols="12">
                  <v-text-field
                    label="Nome do produto*"
                    required
                    v-model="productName"
                    :rules="nameRules"
                  />
                </v-col>

                <v-col cols="4">
                  <v-text-field
                    label="Quantidade"
                    required
                    v-model.number="productQuantity"
                    :rules="inputRules"
                  />
                </v-col>

                <v-col cols="4">
                  <v-text-field
                    label="Preço*"
                    v-model.number="price"
                    required
                    :rules="inputRules"
                  />
                </v-col>

                <v-col cols="4">
                  <v-text-field label="min*" required v-model.number="minQty" />
                </v-col>

                <v-col cols="12" sm="6">
                  <v-select
                    :items="['Bebida', 'Comida', 'Utensílio', 'higiene']"
                    v-model="category"
                    label="Categoria*"
                    :rules="categoryRules"
                    required
                  ></v-select>
                </v-col>
              </v-row>
            </v-container>
          </v-form>
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">
            Close
          </v-btn>
          <v-btn color="blue darken-1" text @click="submit"> Save </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>


<script>
import api from "../services/api";

export default {
  name: "NewProductPopup",
  data: () => ({
    dialog: false,
    hidden: false,
    productName: "",
    productQuantity: null,
    minQty: 10,
    price: null,
    category: null,
    inputRules: [(v) => v > 0 || "na numero"],
    nameRules: [(v) => v.length >= 3 || "Nome inválido"],
    categoryRules: [(v) => v !== null || "Escolha uma categoria"],
  }),
  methods: {
    async submit() {
      if (this.$refs.newProductForm.validate()) {
        this.dialog = false;

        let newProduct = {
          name: this.productName,
          quantity: this.productQuantity,
          price: this.price,
          minQty: this.minQty,
          category: 3,
        };

        /* make a post request to save in DB */
        try {
          const result = await api.post("/products", newProduct);
          console.log(result);
        } catch (error) {
          console.log(error);
        }
      }
    },
  },
};
</script>