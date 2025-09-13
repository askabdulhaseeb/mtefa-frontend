import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
  fatal,
}

class AppLog {
  static LogLevel _minLevel = kDebugMode ? LogLevel.debug : LogLevel.info;
  static final List<LogHandler> _handlers = <LogHandler>[];

  static void setMinLevel(LogLevel level) {
    _minLevel = level;
  }

  static void addHandler(LogHandler handler) {
    _handlers.add(handler);
  }

  static void removeHandler(LogHandler handler) {
    _handlers.remove(handler);
  }

  static void clearHandlers() {
    _handlers.clear();
  }

  static void debug(
    String message, {
    String? name,
    Map<String, dynamic>? extra,
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
  }) {
    _log(
      LogLevel.debug,
      message,
      name: name ?? 'AppLog',
      extra: extra,
      time: time,
      sequenceNumber: sequenceNumber,
      zone: zone,
    );
  }

  static void info(
    String message, {
    String? name,
    Map<String, dynamic>? extra,
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
  }) {
    _log(
      LogLevel.info,
      message,
      name: name ?? 'AppLog',
      extra: extra,
      time: time,
      sequenceNumber: sequenceNumber,
      zone: zone,
    );
  }

  static void warning(
    String message, {
    String? name,
    Map<String, dynamic>? extra,
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
  }) {
    _log(
      LogLevel.warning,
      message,
      name: name ?? 'AppLog',
      extra: extra,
      time: time,
      sequenceNumber: sequenceNumber,
      zone: zone,
    );
  }

  static void error(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
  }) {
    _log(
      LogLevel.error,
      message,
      name: name ?? 'AppLog',
      error: error,
      stackTrace: stackTrace,
      extra: extra,
      time: time,
      sequenceNumber: sequenceNumber,
      zone: zone,
    );
  }

  static void fatal(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
  }) {
    _log(
      LogLevel.fatal,
      message,
      name: name ?? 'AppLog',
      error: error,
      stackTrace: stackTrace,
      extra: extra,
      time: time,
      sequenceNumber: sequenceNumber,
      zone: zone,
    );
  }

  static void _log(
    LogLevel level,
    String message, {
    required String name,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
  }) {
    if (level.index < _minLevel.index) return;

    final LogEntry entry = LogEntry(
      level: level,
      message: message,
      name: name,
      error: error,
      stackTrace: stackTrace,
      extra: extra,
      time: time ?? DateTime.now(),
      sequenceNumber: sequenceNumber,
      zone: zone,
    );

    // Send to all handlers
    for (final LogHandler handler in _handlers) {
      try {
        handler.handle(entry);
      } catch (e) {
        // Ignore handler errors to prevent infinite loops
      }
    }

    // Default console output
    _defaultConsoleOutput(entry);
  }

  static void _defaultConsoleOutput(LogEntry entry) {
    if (!kDebugMode && entry.level == LogLevel.debug) return;

    final String levelIcon = _getLevelIcon(entry.level);
    final String formattedMessage = entry.extra != null 
        ? '${entry.message}\nExtra: ${jsonEncode(entry.extra)}'
        : entry.message;

    log(
      formattedMessage,
      name: '$levelIcon ${entry.name}',
      time: entry.time,
      sequenceNumber: entry.sequenceNumber,
      level: _getDartLogLevel(entry.level),
      zone: entry.zone,
      error: entry.error,
      stackTrace: entry.stackTrace,
    );
  }

  static String _getLevelIcon(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🐛';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.error:
        return '❌';
      case LogLevel.fatal:
        return '💀';
    }
  }

  static int _getDartLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
      case LogLevel.fatal:
        return 1200;
    }
  }
}

class LogEntry {
  const LogEntry({
    required this.level,
    required this.message,
    required this.name,
    required this.time,
    this.error,
    this.stackTrace,
    this.extra,
    this.sequenceNumber,
    this.zone,
  });

  final LogLevel level;
  final String message;
  final String name;
  final DateTime time;
  final Object? error;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? extra;
  final int? sequenceNumber;
  final Zone? zone;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'level': level.name,
    'message': message,
    'name': name,
    'time': time.toIso8601String(),
    'error': error?.toString(),
    'stackTrace': stackTrace?.toString(),
    'extra': extra,
    'sequenceNumber': sequenceNumber,
  };
}

abstract class LogHandler {
  void handle(LogEntry entry);
}

class FileLogHandler implements LogHandler {
  FileLogHandler({
    required this.filePath,
    this.maxFileSize = 10 * 1024 * 1024, // 10MB
    this.maxFiles = 5,
  });

  final String filePath;
  final int maxFileSize;
  final int maxFiles;

  @override
  void handle(LogEntry entry) {
    // Implementation would write to file
    // This is a placeholder for the interface
  }
}

class RemoteLogHandler implements LogHandler {
  RemoteLogHandler({
    required this.endpoint,
    this.batchSize = 50,
    this.flushInterval = const Duration(seconds: 30),
  });

  final String endpoint;
  final int batchSize;
  final Duration flushInterval;
  final List<LogEntry> _buffer = <LogEntry>[];

  @override
  void handle(LogEntry entry) {
    _buffer.add(entry);
    if (_buffer.length >= batchSize) {
      _flush();
    }
  }

  void _flush() {
    // Implementation would send logs to remote endpoint
    // This is a placeholder for the interface
    _buffer.clear();
  }
}
