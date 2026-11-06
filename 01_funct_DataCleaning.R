# Columns every cleaned QB file must contain
required_cols <- c("season", "player_id", "player_name", "team", "games",
                   "pass_yds", "pass_td", "pass_int", "rush_yds", "rush_td",
                   "win_pct", "mvp")

# load_qb_data(): reads the QB candidates file and checks its columns.
load_qb_data <- function(path = "candidates_21-25.csv") {
  df <- readr::read_csv(path, show_col_types = FALSE)
  missing <- setdiff(required_cols, names(df))
  if (length(missing) > 0) stop("Missing columns: ", paste(missing, collapse = ", "))
  df
}

# load_winners_data(): reads the MVP winners file, drops the blank row under the header, and renames the columns.
load_winners_data <- function(path = "MVP-winners_21-25.csv") {
  w <- readr::read_csv(path, show_col_types = FALSE)
  needed <- c("Year", "Pos", "Player", "Tm")
  if (!all(needed %in% names(w))) stop("Winners file must have columns: ", paste(needed, collapse = ", "))
  w |>
    dplyr::filter(!is.na(Year)) |>
    dplyr::transmute(season = as.integer(Year), position = Pos,
                     player_name = Player, team_name = Tm)
}

# check_winners(): counts candidates and MVPs per season (should be 1 MVP each).
check_winners <- function(df) {
  df |>
    dplyr::group_by(season) |>
    dplyr::summarise(n_candidates = dplyr::n(), n_mvp = sum(mvp), .groups = "drop")
}

# add_qb_features(): creates per-game and combined statistics and an MVP factor.
add_qb_features <- function(df) {
  df |>
    dplyr::mutate(
      pass_yds_pg  = pass_yds / games,
      pass_td_pg   = pass_td / games,
      pass_int_pg  = pass_int / games,
      rush_yds_pg  = rush_yds / games,
      td_int_ratio = pass_td / pmax(pass_int, 1),
      total_td     = pass_td + rush_td,
      mvp_flag     = mvp,
      mvp          = factor(mvp, levels = c(0, 1), labels = c("Other QB", "MVP"))
    )
}

# add_season_ranks(): ranks each QB within his season on chosen statistics
add_season_ranks <- function(df, stats, lower_is_better = "pass_int_pg") {
  for (s in stats) {
    sign <- if (s %in% lower_is_better) 1 else -1
    df[[paste0(s, "_rank")]] <- ave(sign * df[[s]], df$season,
                                    FUN = function(x) rank(x, ties.method = "min"))
  }
  df
}
