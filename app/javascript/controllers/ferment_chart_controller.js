import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { labels: Array, data: Array }

  connect() {
    const script = document.createElement('script')
    script.src = 'https://cdn.jsdelivr.net/npm/chart.js'
    script.onload = () => {
      const ctx = this.element.getContext('2d')

      const gradient = ctx.createLinearGradient(0, 0, 0, 300)
      gradient.addColorStop(0, 'rgba(255, 193, 7, 0.4)')
      gradient.addColorStop(1, 'rgba(255, 193, 7, 0.0)')

      new Chart(this.element, {
        type: 'line',
        data: {
          labels: this.labelsValue,
          datasets: [{
            label: 'Fermentos creados',
            data: this.dataValue,
            fill: true,
            backgroundColor: gradient,
            borderColor: '#ffc107',
            borderWidth: 2,
            pointBackgroundColor: '#ffc107',
            pointRadius: 5,
            pointHoverRadius: 7,
            tension: 0.4
          }]
        },
        options: {
          responsive: true,
          plugins: {
            legend: { display: false },
            tooltip: {
              backgroundColor: '#1a1a1a',
              borderColor: '#ffc107',
              borderWidth: 1,
              titleColor: '#ffc107',
              bodyColor: '#ccc',
            }
          },
          scales: {
            y: {
              beginAtZero: true,
              ticks: { color: '#888', stepSize: 1 },
              grid: { color: 'rgba(255,255,255,0.05)' }
            },
            x: {
              ticks: { color: '#888' },
              grid: { display: false }
            }
          }
        }
      })
    }
    document.head.appendChild(script)
  }
}
