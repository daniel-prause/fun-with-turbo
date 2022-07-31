
import { Controller } from "@hotwired/stimulus";
import { get } from '@rails/request.js';

export default class extends Controller {

  static targets = ["searchField", "searchForm"]
  async search() {
    const documentURL = new URL(this.searchFormTarget.action);
    if (this.searchFieldTarget.value != '') {
      documentURL.searchParams.set(
        'search',
        this.searchFieldTarget.value
      );
    }
    window.history.replaceState({}, document.title, documentURL);
    await get(documentURL, {
      responseKind: 'turbo-stream'
    })
  }
}
