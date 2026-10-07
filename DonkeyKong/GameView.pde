class GameView {
  PApplet app;
  GameView(PApplet app) { this.app = app; }

  public void render(GameController c) {
    String estado = c.getNombreEstado();
    if (estado.equals("MENU")) {
      dibujarMenu();
    } else {
      dibujarJuego(c);
      if (estado.equals("PAUSADO")) dibujarPausa();
      if (estado.equals("VICTORIA")) dibujarVictoria(c);
      if (estado.equals("GAME OVER")) dibujarGameOver(c);
    }
  }

  private void dibujarMenu() {
    app.background(20, 20, 40);
    app.fill(255);
    app.textAlign(CENTER, CENTER);
    app.textSize(42);
    app.text("DONKEY KONG - PROTOTIPO", app.width / 2, 120);
    app.textSize(18);
    app.text("ESPACIO: Nueva partida", app.width / 2, 280);
    app.text("C: Cargar partida guardada", app.width / 2, 320);
    app.text("Controles: A/D mover, W/S escaleras, ESPACIO saltar", app.width / 2, 400);
    app.text("P pausa, G guardar, ESC menu", app.width / 2, 440);
  }

  private void dibujarJuego(GameController c) {
    app.background(30, 30, 60);
    Partida p = c.getPartida();
    if (p == null) return;
    Nivel n = p.getNivel();

    // Plataformas
    app.noStroke();
    app.fill(180, 60, 60);
    for (Plataforma pl : n.plataformas) {
      app.rect(pl.getX(), pl.getY(), pl.getW(), pl.getH());
    }

    // Escaleras
    app.fill(200, 180, 80);
    for (Escalera e : n.escaleras) {
      app.rect(e.getX(), e.getY(), e.getW(), e.getH());
    }

    // Donkey Kong
    app.fill(120, 70, 30);
    app.rect(n.dk.getX(), n.dk.getY(), n.dk.getW(), n.dk.getH());
    app.fill(255);
    app.textSize(12);
    app.textAlign(CENTER, CENTER);
    app.text("DK", n.dk.getX() + n.dk.getW() / 2, n.dk.getY() + n.dk.getH() / 2);

    // Pauline
    app.fill(255, 150, 200);
    app.rect(n.pauline.getX(), n.pauline.getY(), n.pauline.getW(), n.pauline.getH());
    app.fill(0);
    app.textSize(10);
    app.text("HELP", n.pauline.getX() + n.pauline.getW() / 2,
             n.pauline.getY() + n.pauline.getH() / 2);

    // Barriles
    app.fill(160, 100, 50);
    for (Barril b : n.barriles) {
      app.ellipse(b.getX() + b.getW() / 2, b.getY() + b.getH() / 2,
                  b.getW(), b.getH());
    }

    // Mario
    Mario m = p.getMario();
    app.fill(220, 30, 30);
    app.rect(m.getX(), m.getY(), m.getW(), m.getH());
    app.fill(255);
    app.textSize(10);
    app.text("M", m.getX() + m.getW() / 2, m.getY() + m.getH() / 2);

    // HUD
    dibujarHUD(p);
  }

  private void dibujarHUD(Partida p) {
    app.fill(0, 0, 0, 150);
    app.noStroke();
    app.rect(0, 0, app.width, 30);
    app.fill(255);
    app.textAlign(LEFT, CENTER);
    app.textSize(16);
    app.text("Vidas: " + p.getVidas(), 20, 15);
    app.text("Puntaje: " + p.getPuntaje(), 150, 15);
    app.textAlign(RIGHT, CENTER);
    app.text("G: guardar | P: pausa | ESC: menu", app.width - 20, 15);
  }

  private void dibujarPausa() {
    app.fill(0, 0, 0, 180);
    app.rect(0, 0, app.width, app.height);
    app.fill(255);
    app.textAlign(CENTER, CENTER);
    app.textSize(48);
    app.text("PAUSA", app.width / 2, app.height / 2 - 20);
    app.textSize(18);
    app.text("P: continuar | ESC: menu", app.width / 2, app.height / 2 + 40);
  }

  private void dibujarVictoria(GameController c) {
    Partida p = c.getPartida();
    app.fill(0, 0, 0, 180);
    app.rect(0, 0, app.width, app.height);
    app.fill(255, 220, 60);
    app.textAlign(CENTER, CENTER);
    app.textSize(52);
    app.text("¡VICTORIA!", app.width / 2, app.height / 2 - 40);
    app.fill(255);
    app.textSize(22);
    app.text("Puntaje final: " + (p != null ? p.getPuntaje() : 0),
             app.width / 2, app.height / 2 + 20);
    app.textSize(18);
    app.text("R: nueva partida | ESC: menu", app.width / 2, app.height / 2 + 70);
  }

  private void dibujarGameOver(GameController c) {
    Partida p = c.getPartida();
    app.fill(0, 0, 0, 200);
    app.rect(0, 0, app.width, app.height);
    app.fill(230, 60, 60);
    app.textAlign(CENTER, CENTER);
    app.textSize(52);
    app.text("GAME OVER", app.width / 2, app.height / 2 - 40);
    app.fill(255);
    app.textSize(22);
    app.text("Puntaje final: " + (p != null ? p.getPuntaje() : 0),
             app.width / 2, app.height / 2 + 20);
    app.textSize(18);
    app.text("R: reintentar | ESC: menu", app.width / 2, app.height / 2 + 70);
  }
}
