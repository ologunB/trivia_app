library ntp;

import 'dart:async';
import 'package:universal_io/io.dart'
    show
        InternetAddress,
        InternetAddressType,
        RawDatagramSocket,
        RawSocketEvent,
        Datagram;
import 'dart:math';

part 'ntp/ntp.dart';

part 'ntp/ntp_message.dart';

/// A library to get and parse data received from NTP services
