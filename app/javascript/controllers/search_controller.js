
import { Controller } from "@hotwired/stimulus";
import { get } from '@rails/request.js';
import { useDebounce } from "stimulus-use";

export default class extends Controller {

  static targets = ["searchField", "searchForm"]
  static debounces = [
    'search'
  ]

  connect() {
    useDebounce(this, { wait: 200 })
  }

  reset() {
    if (this.searchFieldTarget.value != '') {
      this.searchFieldTarget.value = ''
      this.search()
    }
  }

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
