class BaseRepository {
  final baseUrl = Uri.parse("https://countriesnow.space/api/v0.1/countries/");

  final baseHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
}
