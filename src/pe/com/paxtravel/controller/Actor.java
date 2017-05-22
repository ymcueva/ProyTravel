package pe.com.paxtravel.controller;
import java.util.List;

public class Actor extends Person {
  public Actor() {
  }

  public List getMovieCredits() { return this.movieCredits; }
  public void setMovieCredits(List movieCredits) {
    this.movieCredits = movieCredits;
  }

  public long getWorth() { return this.worth; }
  public void setWorth(long worth) { this.worth = worth; }

  private List movieCredits;
  private long worth;
}