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
                    v-model="newProduct.name"
                    :rules="nameRules"
                  />
                </v-col>

                <v-col cols="4">
                  <v-text-field
                    label="Quantidade"
                    required
                    v-model.number="newProduct.quantity"
                    :rules="inputRules"
                  />
                </v-col>

                <v-col cols="4">
                  <v-text-field
                    label="Preço*"
                    v-model.number="newProduct.price"
                    required
                    :rules="inputRules"
                  />
                </v-col>

                <v-col cols="4">
                  <v-text-field
                    label="min*"
                    required
                    v-model.number="newProduct.minQty"
                  />
                </v-col>

                <v-col cols="12" sm="6">
                  <v-select
                    :items="['Bebida', 'Comida', 'Utensílio', 'Higiene']"
                    v-model="newProduct.categoryId"
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
import { mapActions } from "vuex";

export default {
  name: "AddProductForm",
  data: () => ({
    dialog: false,
    hidden: false,
    newProduct: {
      name: "",
      quantity: null,
      minQty: 10,
      price: null,
      categoryId: null,
    },
    inputRules: [(v) => v > 0 || "na numero"],
    nameRules: [(v) => v.length >= 3 || "Nome inválido"],
    categoryRules: [(v) => v !== null || "Escolha uma categoria"],
  }),
  methods: {
    ...mapActions(["addNewProduct"]),
    submit() {
      if (this.$refs.newProductForm.validate()) {
        this.dialog = false;

        switch (this.newProduct.categoryId) {
          case "Bebida":
            this.newProduct.categoryId = 1;
            break;
          case "Comida":
            this.newProduct.categoryId = 2;
            break;
          case "Utensílio":
            this.newProduct.categoryId = 3;
            break;
          case "Higiene":
            this.newProduct.categoryId = 4;
            break;
          default:
            this.newProduct.categoryId = 1;
        }

        console.log(this.newProduct);
        /* make a post request to save in DB */
        this.addNewProduct(this.newProduct);
      }
    },
  },
};
</script>