import 'dart:typed_data';
import 'dart:async';

extension StreamToBytes on Stream<List<int>> {
  Future<Uint8List> toBytes() async {
    final chunks = await this.toList();
    return Uint8List.fromList(chunks.expand((x) => x).toList());
  }
}
