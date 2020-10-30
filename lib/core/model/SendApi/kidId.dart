

import 'package:flutter/material.dart';
import 'package:turing_academy/core/model/sendable.dart';

/// The kid change class is used to transfer all relevant content for updating
/// an existing kid on the little-marker server.
///

class KidIdSend extends Sendable {
  final int kidId;


  KidIdSend({
        this.kidId,
       });

  /// Create the JSON required by Dayblizz API server for updating a post.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kid_id']=this.kidId;

    return data;
  }
}
