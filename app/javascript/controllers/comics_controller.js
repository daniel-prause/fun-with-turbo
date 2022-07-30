
import { Controller } from "@hotwired/stimulus";
import { post } from '@rails/request.js';

export default class extends Controller {

  static targets = ["searchField", "searchForm"]
  async search() {
    post(this.searchFormTarget.action, {
      responseKind: "turbo-stream",
      body: {
        search: this.searchFieldTarget.value
      }
    })
  }
}
