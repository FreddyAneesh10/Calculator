class ResultFormatter {

  String format(double result) {

    String res = result.toString();

    if (res.endsWith('.0')) {
      res = res.substring(0, res.length - 2);
    }

    return res.replaceAll('.', ',');
  }

}