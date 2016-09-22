defmodule GradeScraper do
  use Hound.Helpers

  @username_envvar "FERNUNI_POS_USERNAME"
  @password_envvar "FERNUNI_POS_PASSWORD"

  @login_uri "https://pos.fernuni-hagen.de/qisserver/rds?state=user&type=0"
  # not kidding
  @username_field_id "asdf"
  @password_field_id "fdsa"

  @exam_management_link "Prüfungsverwaltung"
  @grade_listing_link "Notenübersicht"

  # this is stupid, there is no nice selector, let's hope this doesn't get moved around
  @bachelor_grades_selector "form a"

  @exam_search_string "Stochastik"

  def start(_type, _args) do
    {username, password} = get_credentials

    scrape(username, password)

    {:ok, self()}
  end

  defp get_credentials do
    username = get_from_env_or_read(@username_envvar, "Please enter username: ")
    password = get_from_env_or_read(@password_envvar, "Please enter password: ")

    {username, password}
  end

  defp get_from_env_or_read(envvar, prompt) do
    configured_value = System.get_env(envvar)

    case configured_value do
      nil -> IO.gets(prompt) |> chomp
      _ -> configured_value
    end
  end

  defp chomp(string) do
    string |> String.trim_trailing("\n")
  end

  defp scrape(username, password) do
    Hound.start_session

    navigate_to @login_uri
    find_element(:id, @username_field_id) |> fill_field(username)
    pw_field = find_element(:id, @password_field_id)
    pw_field |> fill_field(password)
    pw_field |> submit_element

    find_element(:link_text, @exam_management_link) |> click
    find_element(:link_text, @grade_listing_link) |> click
    find_element(:css, @bachelor_grades_selector) |> click

    if visible_page_text() |> String.contains?(@exam_search_string) do
      IO.puts "GRADE IS AVAILABLE!"
    else
      IO.puts "no grade yet :("
    end

    Hound.end_session
  end
end
