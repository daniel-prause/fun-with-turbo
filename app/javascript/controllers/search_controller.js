
import { Controller } from "@hotwired/stimulus";
import { get } from '@rails/request.js';

export default class extends Controller {

  static targets = ["searchField", "searchForm"]
  async search() {
    const documentURL = new URL(this.searchFormTarget.action);
    documentURL.searchParams.set(
      'search',
      this.searchFieldTarget.value
    );
    get(documentURL, {
      responseKind: 'turbo-stream'
    })
  }
}
