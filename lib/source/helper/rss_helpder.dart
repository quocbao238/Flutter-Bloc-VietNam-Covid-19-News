class RssHelper {
  static String getImageFromFeed(String description) {
    int indexStart = description.indexOf('src=\"') + 5;
    int indexEnd = description.indexOf(' align=') - 1;
    return description.substring(indexStart, indexEnd);
  }

  // Thay đổi kích thước hình height x width
  static String changeSizeImage(
      {required String imageUrl, required int width, required height}) {
    int indexEnd = imageUrl.indexOf('Uploaded') - 1;
    String newSize = "${height}x$width";
    String reuslt = imageUrl.replaceRange(27, indexEnd, newSize);
    return reuslt;
  }
}
