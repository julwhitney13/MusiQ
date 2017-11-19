# Function obtained from Nat Tuck draw project.
defmodule MusiqWeb.Helpers do
  def page_name(mm, tt) do
    modu = String.replace(to_string(mm), ~r/^.*\./, "")
    tmpl = String.replace(to_string(tt), ~r/\..*$/, "")
    "#{modu}/#{tmpl}"
  end

  def get_ID_from_conn(conn) do
    tuple = List.keyfind(conn.req_headers, "referer", 0)
    url = elem(tuple, 1)
    split = String.split(url, "/")
    String.to_integer(List.last(split))
  end
end
