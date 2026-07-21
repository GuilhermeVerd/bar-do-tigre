// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('oficial'),
  );
  static const VerificationMeta _pinMeta = const VerificationMeta('pin');
  @override
  late final GeneratedColumn<String> pin = GeneratedColumn<String>(
    'pin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pinAtivoMeta = const VerificationMeta(
    'pinAtivo',
  );
  @override
  late final GeneratedColumn<bool> pinAtivo = GeneratedColumn<bool>(
    'pin_ativo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pin_ativo" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
    'ativo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ativo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _criadoEmMeta = const VerificationMeta(
    'criadoEm',
  );
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
    'criado_em',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nome,
    tipo,
    pin,
    pinAtivo,
    ativo,
    criadoEm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    }
    if (data.containsKey('pin')) {
      context.handle(
        _pinMeta,
        pin.isAcceptableOrUnknown(data['pin']!, _pinMeta),
      );
    }
    if (data.containsKey('pin_ativo')) {
      context.handle(
        _pinAtivoMeta,
        pinAtivo.isAcceptableOrUnknown(data['pin_ativo']!, _pinAtivoMeta),
      );
    }
    if (data.containsKey('ativo')) {
      context.handle(
        _ativoMeta,
        ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta),
      );
    }
    if (data.containsKey('criado_em')) {
      context.handle(
        _criadoEmMeta,
        criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      pin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin'],
      ),
      pinAtivo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pin_ativo'],
      )!,
      ativo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ativo'],
      )!,
      criadoEm: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}criado_em'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int id;
  final String nome;
  final String tipo;
  final String? pin;
  final bool pinAtivo;
  final bool ativo;
  final DateTime criadoEm;
  const Usuario({
    required this.id,
    required this.nome,
    required this.tipo,
    this.pin,
    required this.pinAtivo,
    required this.ativo,
    required this.criadoEm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['tipo'] = Variable<String>(tipo);
    if (!nullToAbsent || pin != null) {
      map['pin'] = Variable<String>(pin);
    }
    map['pin_ativo'] = Variable<bool>(pinAtivo);
    map['ativo'] = Variable<bool>(ativo);
    map['criado_em'] = Variable<DateTime>(criadoEm);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      id: Value(id),
      nome: Value(nome),
      tipo: Value(tipo),
      pin: pin == null && nullToAbsent ? const Value.absent() : Value(pin),
      pinAtivo: Value(pinAtivo),
      ativo: Value(ativo),
      criadoEm: Value(criadoEm),
    );
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      tipo: serializer.fromJson<String>(json['tipo']),
      pin: serializer.fromJson<String?>(json['pin']),
      pinAtivo: serializer.fromJson<bool>(json['pinAtivo']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'tipo': serializer.toJson<String>(tipo),
      'pin': serializer.toJson<String?>(pin),
      'pinAtivo': serializer.toJson<bool>(pinAtivo),
      'ativo': serializer.toJson<bool>(ativo),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
    };
  }

  Usuario copyWith({
    int? id,
    String? nome,
    String? tipo,
    Value<String?> pin = const Value.absent(),
    bool? pinAtivo,
    bool? ativo,
    DateTime? criadoEm,
  }) => Usuario(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    tipo: tipo ?? this.tipo,
    pin: pin.present ? pin.value : this.pin,
    pinAtivo: pinAtivo ?? this.pinAtivo,
    ativo: ativo ?? this.ativo,
    criadoEm: criadoEm ?? this.criadoEm,
  );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      pin: data.pin.present ? data.pin.value : this.pin,
      pinAtivo: data.pinAtivo.present ? data.pinAtivo.value : this.pinAtivo,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('tipo: $tipo, ')
          ..write('pin: $pin, ')
          ..write('pinAtivo: $pinAtivo, ')
          ..write('ativo: $ativo, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nome, tipo, pin, pinAtivo, ativo, criadoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.tipo == this.tipo &&
          other.pin == this.pin &&
          other.pinAtivo == this.pinAtivo &&
          other.ativo == this.ativo &&
          other.criadoEm == this.criadoEm);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> tipo;
  final Value<String?> pin;
  final Value<bool> pinAtivo;
  final Value<bool> ativo;
  final Value<DateTime> criadoEm;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.tipo = const Value.absent(),
    this.pin = const Value.absent(),
    this.pinAtivo = const Value.absent(),
    this.ativo = const Value.absent(),
    this.criadoEm = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    this.tipo = const Value.absent(),
    this.pin = const Value.absent(),
    this.pinAtivo = const Value.absent(),
    this.ativo = const Value.absent(),
    this.criadoEm = const Value.absent(),
  }) : nome = Value(nome);
  static Insertable<Usuario> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? tipo,
    Expression<String>? pin,
    Expression<bool>? pinAtivo,
    Expression<bool>? ativo,
    Expression<DateTime>? criadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (tipo != null) 'tipo': tipo,
      if (pin != null) 'pin': pin,
      if (pinAtivo != null) 'pin_ativo': pinAtivo,
      if (ativo != null) 'ativo': ativo,
      if (criadoEm != null) 'criado_em': criadoEm,
    });
  }

  UsuariosCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<String>? tipo,
    Value<String?>? pin,
    Value<bool>? pinAtivo,
    Value<bool>? ativo,
    Value<DateTime>? criadoEm,
  }) {
    return UsuariosCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
      pin: pin ?? this.pin,
      pinAtivo: pinAtivo ?? this.pinAtivo,
      ativo: ativo ?? this.ativo,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (pin.present) {
      map['pin'] = Variable<String>(pin.value);
    }
    if (pinAtivo.present) {
      map['pin_ativo'] = Variable<bool>(pinAtivo.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('tipo: $tipo, ')
          ..write('pin: $pin, ')
          ..write('pinAtivo: $pinAtivo, ')
          ..write('ativo: $ativo, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }
}

class $ProdutosTable extends Produtos with TableInfo<$ProdutosTable, Produto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProdutosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriaMeta = const VerificationMeta(
    'categoria',
  );
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
    'categoria',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precoCentavosMeta = const VerificationMeta(
    'precoCentavos',
  );
  @override
  late final GeneratedColumn<int> precoCentavos = GeneratedColumn<int>(
    'preco_centavos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estoqueInicialMeta = const VerificationMeta(
    'estoqueInicial',
  );
  @override
  late final GeneratedColumn<int> estoqueInicial = GeneratedColumn<int>(
    'estoque_inicial',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estoqueAtualMeta = const VerificationMeta(
    'estoqueAtual',
  );
  @override
  late final GeneratedColumn<int> estoqueAtual = GeneratedColumn<int>(
    'estoque_atual',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fotoPathMeta = const VerificationMeta(
    'fotoPath',
  );
  @override
  late final GeneratedColumn<String> fotoPath = GeneratedColumn<String>(
    'foto_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
    'ativo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ativo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _criadoEmMeta = const VerificationMeta(
    'criadoEm',
  );
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
    'criado_em',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nome,
    categoria,
    precoCentavos,
    estoqueInicial,
    estoqueAtual,
    fotoPath,
    ativo,
    criadoEm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'produtos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Produto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(
        _categoriaMeta,
        categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta),
      );
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    if (data.containsKey('preco_centavos')) {
      context.handle(
        _precoCentavosMeta,
        precoCentavos.isAcceptableOrUnknown(
          data['preco_centavos']!,
          _precoCentavosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precoCentavosMeta);
    }
    if (data.containsKey('estoque_inicial')) {
      context.handle(
        _estoqueInicialMeta,
        estoqueInicial.isAcceptableOrUnknown(
          data['estoque_inicial']!,
          _estoqueInicialMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estoqueInicialMeta);
    }
    if (data.containsKey('estoque_atual')) {
      context.handle(
        _estoqueAtualMeta,
        estoqueAtual.isAcceptableOrUnknown(
          data['estoque_atual']!,
          _estoqueAtualMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estoqueAtualMeta);
    }
    if (data.containsKey('foto_path')) {
      context.handle(
        _fotoPathMeta,
        fotoPath.isAcceptableOrUnknown(data['foto_path']!, _fotoPathMeta),
      );
    }
    if (data.containsKey('ativo')) {
      context.handle(
        _ativoMeta,
        ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta),
      );
    }
    if (data.containsKey('criado_em')) {
      context.handle(
        _criadoEmMeta,
        criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Produto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Produto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      categoria: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categoria'],
      )!,
      precoCentavos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preco_centavos'],
      )!,
      estoqueInicial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estoque_inicial'],
      )!,
      estoqueAtual: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estoque_atual'],
      )!,
      fotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}foto_path'],
      ),
      ativo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ativo'],
      )!,
      criadoEm: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}criado_em'],
      )!,
    );
  }

  @override
  $ProdutosTable createAlias(String alias) {
    return $ProdutosTable(attachedDatabase, alias);
  }
}

class Produto extends DataClass implements Insertable<Produto> {
  final int id;
  final String nome;
  final String categoria;
  final int precoCentavos;
  final int estoqueInicial;
  final int estoqueAtual;
  final String? fotoPath;
  final bool ativo;
  final DateTime criadoEm;
  const Produto({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.precoCentavos,
    required this.estoqueInicial,
    required this.estoqueAtual,
    this.fotoPath,
    required this.ativo,
    required this.criadoEm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['categoria'] = Variable<String>(categoria);
    map['preco_centavos'] = Variable<int>(precoCentavos);
    map['estoque_inicial'] = Variable<int>(estoqueInicial);
    map['estoque_atual'] = Variable<int>(estoqueAtual);
    if (!nullToAbsent || fotoPath != null) {
      map['foto_path'] = Variable<String>(fotoPath);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['criado_em'] = Variable<DateTime>(criadoEm);
    return map;
  }

  ProdutosCompanion toCompanion(bool nullToAbsent) {
    return ProdutosCompanion(
      id: Value(id),
      nome: Value(nome),
      categoria: Value(categoria),
      precoCentavos: Value(precoCentavos),
      estoqueInicial: Value(estoqueInicial),
      estoqueAtual: Value(estoqueAtual),
      fotoPath: fotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(fotoPath),
      ativo: Value(ativo),
      criadoEm: Value(criadoEm),
    );
  }

  factory Produto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Produto(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      categoria: serializer.fromJson<String>(json['categoria']),
      precoCentavos: serializer.fromJson<int>(json['precoCentavos']),
      estoqueInicial: serializer.fromJson<int>(json['estoqueInicial']),
      estoqueAtual: serializer.fromJson<int>(json['estoqueAtual']),
      fotoPath: serializer.fromJson<String?>(json['fotoPath']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'categoria': serializer.toJson<String>(categoria),
      'precoCentavos': serializer.toJson<int>(precoCentavos),
      'estoqueInicial': serializer.toJson<int>(estoqueInicial),
      'estoqueAtual': serializer.toJson<int>(estoqueAtual),
      'fotoPath': serializer.toJson<String?>(fotoPath),
      'ativo': serializer.toJson<bool>(ativo),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
    };
  }

  Produto copyWith({
    int? id,
    String? nome,
    String? categoria,
    int? precoCentavos,
    int? estoqueInicial,
    int? estoqueAtual,
    Value<String?> fotoPath = const Value.absent(),
    bool? ativo,
    DateTime? criadoEm,
  }) => Produto(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    categoria: categoria ?? this.categoria,
    precoCentavos: precoCentavos ?? this.precoCentavos,
    estoqueInicial: estoqueInicial ?? this.estoqueInicial,
    estoqueAtual: estoqueAtual ?? this.estoqueAtual,
    fotoPath: fotoPath.present ? fotoPath.value : this.fotoPath,
    ativo: ativo ?? this.ativo,
    criadoEm: criadoEm ?? this.criadoEm,
  );
  Produto copyWithCompanion(ProdutosCompanion data) {
    return Produto(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      precoCentavos: data.precoCentavos.present
          ? data.precoCentavos.value
          : this.precoCentavos,
      estoqueInicial: data.estoqueInicial.present
          ? data.estoqueInicial.value
          : this.estoqueInicial,
      estoqueAtual: data.estoqueAtual.present
          ? data.estoqueAtual.value
          : this.estoqueAtual,
      fotoPath: data.fotoPath.present ? data.fotoPath.value : this.fotoPath,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Produto(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('categoria: $categoria, ')
          ..write('precoCentavos: $precoCentavos, ')
          ..write('estoqueInicial: $estoqueInicial, ')
          ..write('estoqueAtual: $estoqueAtual, ')
          ..write('fotoPath: $fotoPath, ')
          ..write('ativo: $ativo, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nome,
    categoria,
    precoCentavos,
    estoqueInicial,
    estoqueAtual,
    fotoPath,
    ativo,
    criadoEm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Produto &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.categoria == this.categoria &&
          other.precoCentavos == this.precoCentavos &&
          other.estoqueInicial == this.estoqueInicial &&
          other.estoqueAtual == this.estoqueAtual &&
          other.fotoPath == this.fotoPath &&
          other.ativo == this.ativo &&
          other.criadoEm == this.criadoEm);
}

class ProdutosCompanion extends UpdateCompanion<Produto> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> categoria;
  final Value<int> precoCentavos;
  final Value<int> estoqueInicial;
  final Value<int> estoqueAtual;
  final Value<String?> fotoPath;
  final Value<bool> ativo;
  final Value<DateTime> criadoEm;
  const ProdutosCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.categoria = const Value.absent(),
    this.precoCentavos = const Value.absent(),
    this.estoqueInicial = const Value.absent(),
    this.estoqueAtual = const Value.absent(),
    this.fotoPath = const Value.absent(),
    this.ativo = const Value.absent(),
    this.criadoEm = const Value.absent(),
  });
  ProdutosCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String categoria,
    required int precoCentavos,
    required int estoqueInicial,
    required int estoqueAtual,
    this.fotoPath = const Value.absent(),
    this.ativo = const Value.absent(),
    this.criadoEm = const Value.absent(),
  }) : nome = Value(nome),
       categoria = Value(categoria),
       precoCentavos = Value(precoCentavos),
       estoqueInicial = Value(estoqueInicial),
       estoqueAtual = Value(estoqueAtual);
  static Insertable<Produto> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? categoria,
    Expression<int>? precoCentavos,
    Expression<int>? estoqueInicial,
    Expression<int>? estoqueAtual,
    Expression<String>? fotoPath,
    Expression<bool>? ativo,
    Expression<DateTime>? criadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (categoria != null) 'categoria': categoria,
      if (precoCentavos != null) 'preco_centavos': precoCentavos,
      if (estoqueInicial != null) 'estoque_inicial': estoqueInicial,
      if (estoqueAtual != null) 'estoque_atual': estoqueAtual,
      if (fotoPath != null) 'foto_path': fotoPath,
      if (ativo != null) 'ativo': ativo,
      if (criadoEm != null) 'criado_em': criadoEm,
    });
  }

  ProdutosCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<String>? categoria,
    Value<int>? precoCentavos,
    Value<int>? estoqueInicial,
    Value<int>? estoqueAtual,
    Value<String?>? fotoPath,
    Value<bool>? ativo,
    Value<DateTime>? criadoEm,
  }) {
    return ProdutosCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      categoria: categoria ?? this.categoria,
      precoCentavos: precoCentavos ?? this.precoCentavos,
      estoqueInicial: estoqueInicial ?? this.estoqueInicial,
      estoqueAtual: estoqueAtual ?? this.estoqueAtual,
      fotoPath: fotoPath ?? this.fotoPath,
      ativo: ativo ?? this.ativo,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (precoCentavos.present) {
      map['preco_centavos'] = Variable<int>(precoCentavos.value);
    }
    if (estoqueInicial.present) {
      map['estoque_inicial'] = Variable<int>(estoqueInicial.value);
    }
    if (estoqueAtual.present) {
      map['estoque_atual'] = Variable<int>(estoqueAtual.value);
    }
    if (fotoPath.present) {
      map['foto_path'] = Variable<String>(fotoPath.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdutosCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('categoria: $categoria, ')
          ..write('precoCentavos: $precoCentavos, ')
          ..write('estoqueInicial: $estoqueInicial, ')
          ..write('estoqueAtual: $estoqueAtual, ')
          ..write('fotoPath: $fotoPath, ')
          ..write('ativo: $ativo, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }
}

class $RetiradasTable extends Retiradas
    with TableInfo<$RetiradasTable, Retirada> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RetiradasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _totalCentavosMeta = const VerificationMeta(
    'totalCentavos',
  );
  @override
  late final GeneratedColumn<int> totalCentavos = GeneratedColumn<int>(
    'total_centavos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataHoraMeta = const VerificationMeta(
    'dataHora',
  );
  @override
  late final GeneratedColumn<DateTime> dataHora = GeneratedColumn<DateTime>(
    'data_hora',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _mesReferenciaMeta = const VerificationMeta(
    'mesReferencia',
  );
  @override
  late final GeneratedColumn<String> mesReferencia = GeneratedColumn<String>(
    'mes_referencia',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechadaMeta = const VerificationMeta(
    'fechada',
  );
  @override
  late final GeneratedColumn<bool> fechada = GeneratedColumn<bool>(
    'fechada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("fechada" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    usuarioId,
    totalCentavos,
    dataHora,
    mesReferencia,
    fechada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'retiradas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Retirada> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('total_centavos')) {
      context.handle(
        _totalCentavosMeta,
        totalCentavos.isAcceptableOrUnknown(
          data['total_centavos']!,
          _totalCentavosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalCentavosMeta);
    }
    if (data.containsKey('data_hora')) {
      context.handle(
        _dataHoraMeta,
        dataHora.isAcceptableOrUnknown(data['data_hora']!, _dataHoraMeta),
      );
    }
    if (data.containsKey('mes_referencia')) {
      context.handle(
        _mesReferenciaMeta,
        mesReferencia.isAcceptableOrUnknown(
          data['mes_referencia']!,
          _mesReferenciaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mesReferenciaMeta);
    }
    if (data.containsKey('fechada')) {
      context.handle(
        _fechadaMeta,
        fechada.isAcceptableOrUnknown(data['fechada']!, _fechadaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Retirada map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Retirada(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      )!,
      totalCentavos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_centavos'],
      )!,
      dataHora: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_hora'],
      )!,
      mesReferencia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mes_referencia'],
      )!,
      fechada: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}fechada'],
      )!,
    );
  }

  @override
  $RetiradasTable createAlias(String alias) {
    return $RetiradasTable(attachedDatabase, alias);
  }
}

class Retirada extends DataClass implements Insertable<Retirada> {
  final int id;
  final int usuarioId;
  final int totalCentavos;
  final DateTime dataHora;
  final String mesReferencia;
  final bool fechada;
  const Retirada({
    required this.id,
    required this.usuarioId,
    required this.totalCentavos,
    required this.dataHora,
    required this.mesReferencia,
    required this.fechada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<int>(usuarioId);
    map['total_centavos'] = Variable<int>(totalCentavos);
    map['data_hora'] = Variable<DateTime>(dataHora);
    map['mes_referencia'] = Variable<String>(mesReferencia);
    map['fechada'] = Variable<bool>(fechada);
    return map;
  }

  RetiradasCompanion toCompanion(bool nullToAbsent) {
    return RetiradasCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      totalCentavos: Value(totalCentavos),
      dataHora: Value(dataHora),
      mesReferencia: Value(mesReferencia),
      fechada: Value(fechada),
    );
  }

  factory Retirada.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Retirada(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      totalCentavos: serializer.fromJson<int>(json['totalCentavos']),
      dataHora: serializer.fromJson<DateTime>(json['dataHora']),
      mesReferencia: serializer.fromJson<String>(json['mesReferencia']),
      fechada: serializer.fromJson<bool>(json['fechada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'totalCentavos': serializer.toJson<int>(totalCentavos),
      'dataHora': serializer.toJson<DateTime>(dataHora),
      'mesReferencia': serializer.toJson<String>(mesReferencia),
      'fechada': serializer.toJson<bool>(fechada),
    };
  }

  Retirada copyWith({
    int? id,
    int? usuarioId,
    int? totalCentavos,
    DateTime? dataHora,
    String? mesReferencia,
    bool? fechada,
  }) => Retirada(
    id: id ?? this.id,
    usuarioId: usuarioId ?? this.usuarioId,
    totalCentavos: totalCentavos ?? this.totalCentavos,
    dataHora: dataHora ?? this.dataHora,
    mesReferencia: mesReferencia ?? this.mesReferencia,
    fechada: fechada ?? this.fechada,
  );
  Retirada copyWithCompanion(RetiradasCompanion data) {
    return Retirada(
      id: data.id.present ? data.id.value : this.id,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      totalCentavos: data.totalCentavos.present
          ? data.totalCentavos.value
          : this.totalCentavos,
      dataHora: data.dataHora.present ? data.dataHora.value : this.dataHora,
      mesReferencia: data.mesReferencia.present
          ? data.mesReferencia.value
          : this.mesReferencia,
      fechada: data.fechada.present ? data.fechada.value : this.fechada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Retirada(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('totalCentavos: $totalCentavos, ')
          ..write('dataHora: $dataHora, ')
          ..write('mesReferencia: $mesReferencia, ')
          ..write('fechada: $fechada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    usuarioId,
    totalCentavos,
    dataHora,
    mesReferencia,
    fechada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Retirada &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.totalCentavos == this.totalCentavos &&
          other.dataHora == this.dataHora &&
          other.mesReferencia == this.mesReferencia &&
          other.fechada == this.fechada);
}

class RetiradasCompanion extends UpdateCompanion<Retirada> {
  final Value<int> id;
  final Value<int> usuarioId;
  final Value<int> totalCentavos;
  final Value<DateTime> dataHora;
  final Value<String> mesReferencia;
  final Value<bool> fechada;
  const RetiradasCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.totalCentavos = const Value.absent(),
    this.dataHora = const Value.absent(),
    this.mesReferencia = const Value.absent(),
    this.fechada = const Value.absent(),
  });
  RetiradasCompanion.insert({
    this.id = const Value.absent(),
    required int usuarioId,
    required int totalCentavos,
    this.dataHora = const Value.absent(),
    required String mesReferencia,
    this.fechada = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       totalCentavos = Value(totalCentavos),
       mesReferencia = Value(mesReferencia);
  static Insertable<Retirada> custom({
    Expression<int>? id,
    Expression<int>? usuarioId,
    Expression<int>? totalCentavos,
    Expression<DateTime>? dataHora,
    Expression<String>? mesReferencia,
    Expression<bool>? fechada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (totalCentavos != null) 'total_centavos': totalCentavos,
      if (dataHora != null) 'data_hora': dataHora,
      if (mesReferencia != null) 'mes_referencia': mesReferencia,
      if (fechada != null) 'fechada': fechada,
    });
  }

  RetiradasCompanion copyWith({
    Value<int>? id,
    Value<int>? usuarioId,
    Value<int>? totalCentavos,
    Value<DateTime>? dataHora,
    Value<String>? mesReferencia,
    Value<bool>? fechada,
  }) {
    return RetiradasCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      totalCentavos: totalCentavos ?? this.totalCentavos,
      dataHora: dataHora ?? this.dataHora,
      mesReferencia: mesReferencia ?? this.mesReferencia,
      fechada: fechada ?? this.fechada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (totalCentavos.present) {
      map['total_centavos'] = Variable<int>(totalCentavos.value);
    }
    if (dataHora.present) {
      map['data_hora'] = Variable<DateTime>(dataHora.value);
    }
    if (mesReferencia.present) {
      map['mes_referencia'] = Variable<String>(mesReferencia.value);
    }
    if (fechada.present) {
      map['fechada'] = Variable<bool>(fechada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RetiradasCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('totalCentavos: $totalCentavos, ')
          ..write('dataHora: $dataHora, ')
          ..write('mesReferencia: $mesReferencia, ')
          ..write('fechada: $fechada')
          ..write(')'))
        .toString();
  }
}

class $ItensRetiradaTable extends ItensRetirada
    with TableInfo<$ItensRetiradaTable, ItensRetiradaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItensRetiradaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _retiradaIdMeta = const VerificationMeta(
    'retiradaId',
  );
  @override
  late final GeneratedColumn<int> retiradaId = GeneratedColumn<int>(
    'retirada_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES retiradas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _produtoIdMeta = const VerificationMeta(
    'produtoId',
  );
  @override
  late final GeneratedColumn<int> produtoId = GeneratedColumn<int>(
    'produto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES produtos (id)',
    ),
  );
  static const VerificationMeta _nomeProdutoMeta = const VerificationMeta(
    'nomeProduto',
  );
  @override
  late final GeneratedColumn<String> nomeProduto = GeneratedColumn<String>(
    'nome_produto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantidadeMeta = const VerificationMeta(
    'quantidade',
  );
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
    'quantidade',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precoUnitarioCentavosMeta =
      const VerificationMeta('precoUnitarioCentavos');
  @override
  late final GeneratedColumn<int> precoUnitarioCentavos = GeneratedColumn<int>(
    'preco_unitario_centavos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalCentavosMeta = const VerificationMeta(
    'subtotalCentavos',
  );
  @override
  late final GeneratedColumn<int> subtotalCentavos = GeneratedColumn<int>(
    'subtotal_centavos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    retiradaId,
    produtoId,
    nomeProduto,
    quantidade,
    precoUnitarioCentavos,
    subtotalCentavos,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'itens_retirada';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItensRetiradaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('retirada_id')) {
      context.handle(
        _retiradaIdMeta,
        retiradaId.isAcceptableOrUnknown(data['retirada_id']!, _retiradaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_retiradaIdMeta);
    }
    if (data.containsKey('produto_id')) {
      context.handle(
        _produtoIdMeta,
        produtoId.isAcceptableOrUnknown(data['produto_id']!, _produtoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_produtoIdMeta);
    }
    if (data.containsKey('nome_produto')) {
      context.handle(
        _nomeProdutoMeta,
        nomeProduto.isAcceptableOrUnknown(
          data['nome_produto']!,
          _nomeProdutoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nomeProdutoMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
        _quantidadeMeta,
        quantidade.isAcceptableOrUnknown(data['quantidade']!, _quantidadeMeta),
      );
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('preco_unitario_centavos')) {
      context.handle(
        _precoUnitarioCentavosMeta,
        precoUnitarioCentavos.isAcceptableOrUnknown(
          data['preco_unitario_centavos']!,
          _precoUnitarioCentavosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precoUnitarioCentavosMeta);
    }
    if (data.containsKey('subtotal_centavos')) {
      context.handle(
        _subtotalCentavosMeta,
        subtotalCentavos.isAcceptableOrUnknown(
          data['subtotal_centavos']!,
          _subtotalCentavosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subtotalCentavosMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItensRetiradaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItensRetiradaData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      retiradaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retirada_id'],
      )!,
      produtoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}produto_id'],
      )!,
      nomeProduto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome_produto'],
      )!,
      quantidade: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantidade'],
      )!,
      precoUnitarioCentavos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preco_unitario_centavos'],
      )!,
      subtotalCentavos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal_centavos'],
      )!,
    );
  }

  @override
  $ItensRetiradaTable createAlias(String alias) {
    return $ItensRetiradaTable(attachedDatabase, alias);
  }
}

class ItensRetiradaData extends DataClass
    implements Insertable<ItensRetiradaData> {
  final int id;
  final int retiradaId;
  final int produtoId;
  final String nomeProduto;
  final int quantidade;
  final int precoUnitarioCentavos;
  final int subtotalCentavos;
  const ItensRetiradaData({
    required this.id,
    required this.retiradaId,
    required this.produtoId,
    required this.nomeProduto,
    required this.quantidade,
    required this.precoUnitarioCentavos,
    required this.subtotalCentavos,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['retirada_id'] = Variable<int>(retiradaId);
    map['produto_id'] = Variable<int>(produtoId);
    map['nome_produto'] = Variable<String>(nomeProduto);
    map['quantidade'] = Variable<int>(quantidade);
    map['preco_unitario_centavos'] = Variable<int>(precoUnitarioCentavos);
    map['subtotal_centavos'] = Variable<int>(subtotalCentavos);
    return map;
  }

  ItensRetiradaCompanion toCompanion(bool nullToAbsent) {
    return ItensRetiradaCompanion(
      id: Value(id),
      retiradaId: Value(retiradaId),
      produtoId: Value(produtoId),
      nomeProduto: Value(nomeProduto),
      quantidade: Value(quantidade),
      precoUnitarioCentavos: Value(precoUnitarioCentavos),
      subtotalCentavos: Value(subtotalCentavos),
    );
  }

  factory ItensRetiradaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItensRetiradaData(
      id: serializer.fromJson<int>(json['id']),
      retiradaId: serializer.fromJson<int>(json['retiradaId']),
      produtoId: serializer.fromJson<int>(json['produtoId']),
      nomeProduto: serializer.fromJson<String>(json['nomeProduto']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      precoUnitarioCentavos: serializer.fromJson<int>(
        json['precoUnitarioCentavos'],
      ),
      subtotalCentavos: serializer.fromJson<int>(json['subtotalCentavos']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'retiradaId': serializer.toJson<int>(retiradaId),
      'produtoId': serializer.toJson<int>(produtoId),
      'nomeProduto': serializer.toJson<String>(nomeProduto),
      'quantidade': serializer.toJson<int>(quantidade),
      'precoUnitarioCentavos': serializer.toJson<int>(precoUnitarioCentavos),
      'subtotalCentavos': serializer.toJson<int>(subtotalCentavos),
    };
  }

  ItensRetiradaData copyWith({
    int? id,
    int? retiradaId,
    int? produtoId,
    String? nomeProduto,
    int? quantidade,
    int? precoUnitarioCentavos,
    int? subtotalCentavos,
  }) => ItensRetiradaData(
    id: id ?? this.id,
    retiradaId: retiradaId ?? this.retiradaId,
    produtoId: produtoId ?? this.produtoId,
    nomeProduto: nomeProduto ?? this.nomeProduto,
    quantidade: quantidade ?? this.quantidade,
    precoUnitarioCentavos: precoUnitarioCentavos ?? this.precoUnitarioCentavos,
    subtotalCentavos: subtotalCentavos ?? this.subtotalCentavos,
  );
  ItensRetiradaData copyWithCompanion(ItensRetiradaCompanion data) {
    return ItensRetiradaData(
      id: data.id.present ? data.id.value : this.id,
      retiradaId: data.retiradaId.present
          ? data.retiradaId.value
          : this.retiradaId,
      produtoId: data.produtoId.present ? data.produtoId.value : this.produtoId,
      nomeProduto: data.nomeProduto.present
          ? data.nomeProduto.value
          : this.nomeProduto,
      quantidade: data.quantidade.present
          ? data.quantidade.value
          : this.quantidade,
      precoUnitarioCentavos: data.precoUnitarioCentavos.present
          ? data.precoUnitarioCentavos.value
          : this.precoUnitarioCentavos,
      subtotalCentavos: data.subtotalCentavos.present
          ? data.subtotalCentavos.value
          : this.subtotalCentavos,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItensRetiradaData(')
          ..write('id: $id, ')
          ..write('retiradaId: $retiradaId, ')
          ..write('produtoId: $produtoId, ')
          ..write('nomeProduto: $nomeProduto, ')
          ..write('quantidade: $quantidade, ')
          ..write('precoUnitarioCentavos: $precoUnitarioCentavos, ')
          ..write('subtotalCentavos: $subtotalCentavos')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    retiradaId,
    produtoId,
    nomeProduto,
    quantidade,
    precoUnitarioCentavos,
    subtotalCentavos,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItensRetiradaData &&
          other.id == this.id &&
          other.retiradaId == this.retiradaId &&
          other.produtoId == this.produtoId &&
          other.nomeProduto == this.nomeProduto &&
          other.quantidade == this.quantidade &&
          other.precoUnitarioCentavos == this.precoUnitarioCentavos &&
          other.subtotalCentavos == this.subtotalCentavos);
}

class ItensRetiradaCompanion extends UpdateCompanion<ItensRetiradaData> {
  final Value<int> id;
  final Value<int> retiradaId;
  final Value<int> produtoId;
  final Value<String> nomeProduto;
  final Value<int> quantidade;
  final Value<int> precoUnitarioCentavos;
  final Value<int> subtotalCentavos;
  const ItensRetiradaCompanion({
    this.id = const Value.absent(),
    this.retiradaId = const Value.absent(),
    this.produtoId = const Value.absent(),
    this.nomeProduto = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.precoUnitarioCentavos = const Value.absent(),
    this.subtotalCentavos = const Value.absent(),
  });
  ItensRetiradaCompanion.insert({
    this.id = const Value.absent(),
    required int retiradaId,
    required int produtoId,
    required String nomeProduto,
    required int quantidade,
    required int precoUnitarioCentavos,
    required int subtotalCentavos,
  }) : retiradaId = Value(retiradaId),
       produtoId = Value(produtoId),
       nomeProduto = Value(nomeProduto),
       quantidade = Value(quantidade),
       precoUnitarioCentavos = Value(precoUnitarioCentavos),
       subtotalCentavos = Value(subtotalCentavos);
  static Insertable<ItensRetiradaData> custom({
    Expression<int>? id,
    Expression<int>? retiradaId,
    Expression<int>? produtoId,
    Expression<String>? nomeProduto,
    Expression<int>? quantidade,
    Expression<int>? precoUnitarioCentavos,
    Expression<int>? subtotalCentavos,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (retiradaId != null) 'retirada_id': retiradaId,
      if (produtoId != null) 'produto_id': produtoId,
      if (nomeProduto != null) 'nome_produto': nomeProduto,
      if (quantidade != null) 'quantidade': quantidade,
      if (precoUnitarioCentavos != null)
        'preco_unitario_centavos': precoUnitarioCentavos,
      if (subtotalCentavos != null) 'subtotal_centavos': subtotalCentavos,
    });
  }

  ItensRetiradaCompanion copyWith({
    Value<int>? id,
    Value<int>? retiradaId,
    Value<int>? produtoId,
    Value<String>? nomeProduto,
    Value<int>? quantidade,
    Value<int>? precoUnitarioCentavos,
    Value<int>? subtotalCentavos,
  }) {
    return ItensRetiradaCompanion(
      id: id ?? this.id,
      retiradaId: retiradaId ?? this.retiradaId,
      produtoId: produtoId ?? this.produtoId,
      nomeProduto: nomeProduto ?? this.nomeProduto,
      quantidade: quantidade ?? this.quantidade,
      precoUnitarioCentavos:
          precoUnitarioCentavos ?? this.precoUnitarioCentavos,
      subtotalCentavos: subtotalCentavos ?? this.subtotalCentavos,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (retiradaId.present) {
      map['retirada_id'] = Variable<int>(retiradaId.value);
    }
    if (produtoId.present) {
      map['produto_id'] = Variable<int>(produtoId.value);
    }
    if (nomeProduto.present) {
      map['nome_produto'] = Variable<String>(nomeProduto.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    if (precoUnitarioCentavos.present) {
      map['preco_unitario_centavos'] = Variable<int>(
        precoUnitarioCentavos.value,
      );
    }
    if (subtotalCentavos.present) {
      map['subtotal_centavos'] = Variable<int>(subtotalCentavos.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItensRetiradaCompanion(')
          ..write('id: $id, ')
          ..write('retiradaId: $retiradaId, ')
          ..write('produtoId: $produtoId, ')
          ..write('nomeProduto: $nomeProduto, ')
          ..write('quantidade: $quantidade, ')
          ..write('precoUnitarioCentavos: $precoUnitarioCentavos, ')
          ..write('subtotalCentavos: $subtotalCentavos')
          ..write(')'))
        .toString();
  }
}

class $MovimentacoesEstoqueTable extends MovimentacoesEstoque
    with TableInfo<$MovimentacoesEstoqueTable, MovimentacoesEstoqueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovimentacoesEstoqueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _produtoIdMeta = const VerificationMeta(
    'produtoId',
  );
  @override
  late final GeneratedColumn<int> produtoId = GeneratedColumn<int>(
    'produto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES produtos (id)',
    ),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _retiradaIdMeta = const VerificationMeta(
    'retiradaId',
  );
  @override
  late final GeneratedColumn<int> retiradaId = GeneratedColumn<int>(
    'retirada_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES retiradas (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantidadeMeta = const VerificationMeta(
    'quantidade',
  );
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
    'quantidade',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estoqueAnteriorMeta = const VerificationMeta(
    'estoqueAnterior',
  );
  @override
  late final GeneratedColumn<int> estoqueAnterior = GeneratedColumn<int>(
    'estoque_anterior',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estoquePosteriorMeta = const VerificationMeta(
    'estoquePosterior',
  );
  @override
  late final GeneratedColumn<int> estoquePosterior = GeneratedColumn<int>(
    'estoque_posterior',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _observacaoMeta = const VerificationMeta(
    'observacao',
  );
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
    'observacao',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dataHoraMeta = const VerificationMeta(
    'dataHora',
  );
  @override
  late final GeneratedColumn<DateTime> dataHora = GeneratedColumn<DateTime>(
    'data_hora',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    produtoId,
    usuarioId,
    retiradaId,
    tipo,
    quantidade,
    estoqueAnterior,
    estoquePosterior,
    observacao,
    dataHora,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movimentacoes_estoque';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovimentacoesEstoqueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('produto_id')) {
      context.handle(
        _produtoIdMeta,
        produtoId.isAcceptableOrUnknown(data['produto_id']!, _produtoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_produtoIdMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    }
    if (data.containsKey('retirada_id')) {
      context.handle(
        _retiradaIdMeta,
        retiradaId.isAcceptableOrUnknown(data['retirada_id']!, _retiradaIdMeta),
      );
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
        _quantidadeMeta,
        quantidade.isAcceptableOrUnknown(data['quantidade']!, _quantidadeMeta),
      );
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('estoque_anterior')) {
      context.handle(
        _estoqueAnteriorMeta,
        estoqueAnterior.isAcceptableOrUnknown(
          data['estoque_anterior']!,
          _estoqueAnteriorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estoqueAnteriorMeta);
    }
    if (data.containsKey('estoque_posterior')) {
      context.handle(
        _estoquePosteriorMeta,
        estoquePosterior.isAcceptableOrUnknown(
          data['estoque_posterior']!,
          _estoquePosteriorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estoquePosteriorMeta);
    }
    if (data.containsKey('observacao')) {
      context.handle(
        _observacaoMeta,
        observacao.isAcceptableOrUnknown(data['observacao']!, _observacaoMeta),
      );
    }
    if (data.containsKey('data_hora')) {
      context.handle(
        _dataHoraMeta,
        dataHora.isAcceptableOrUnknown(data['data_hora']!, _dataHoraMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovimentacoesEstoqueData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovimentacoesEstoqueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      produtoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}produto_id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      ),
      retiradaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retirada_id'],
      ),
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      quantidade: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantidade'],
      )!,
      estoqueAnterior: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estoque_anterior'],
      )!,
      estoquePosterior: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estoque_posterior'],
      )!,
      observacao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observacao'],
      ),
      dataHora: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_hora'],
      )!,
    );
  }

  @override
  $MovimentacoesEstoqueTable createAlias(String alias) {
    return $MovimentacoesEstoqueTable(attachedDatabase, alias);
  }
}

class MovimentacoesEstoqueData extends DataClass
    implements Insertable<MovimentacoesEstoqueData> {
  final int id;
  final int produtoId;
  final int? usuarioId;
  final int? retiradaId;
  final String tipo;
  final int quantidade;
  final int estoqueAnterior;
  final int estoquePosterior;
  final String? observacao;
  final DateTime dataHora;
  const MovimentacoesEstoqueData({
    required this.id,
    required this.produtoId,
    this.usuarioId,
    this.retiradaId,
    required this.tipo,
    required this.quantidade,
    required this.estoqueAnterior,
    required this.estoquePosterior,
    this.observacao,
    required this.dataHora,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['produto_id'] = Variable<int>(produtoId);
    if (!nullToAbsent || usuarioId != null) {
      map['usuario_id'] = Variable<int>(usuarioId);
    }
    if (!nullToAbsent || retiradaId != null) {
      map['retirada_id'] = Variable<int>(retiradaId);
    }
    map['tipo'] = Variable<String>(tipo);
    map['quantidade'] = Variable<int>(quantidade);
    map['estoque_anterior'] = Variable<int>(estoqueAnterior);
    map['estoque_posterior'] = Variable<int>(estoquePosterior);
    if (!nullToAbsent || observacao != null) {
      map['observacao'] = Variable<String>(observacao);
    }
    map['data_hora'] = Variable<DateTime>(dataHora);
    return map;
  }

  MovimentacoesEstoqueCompanion toCompanion(bool nullToAbsent) {
    return MovimentacoesEstoqueCompanion(
      id: Value(id),
      produtoId: Value(produtoId),
      usuarioId: usuarioId == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioId),
      retiradaId: retiradaId == null && nullToAbsent
          ? const Value.absent()
          : Value(retiradaId),
      tipo: Value(tipo),
      quantidade: Value(quantidade),
      estoqueAnterior: Value(estoqueAnterior),
      estoquePosterior: Value(estoquePosterior),
      observacao: observacao == null && nullToAbsent
          ? const Value.absent()
          : Value(observacao),
      dataHora: Value(dataHora),
    );
  }

  factory MovimentacoesEstoqueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovimentacoesEstoqueData(
      id: serializer.fromJson<int>(json['id']),
      produtoId: serializer.fromJson<int>(json['produtoId']),
      usuarioId: serializer.fromJson<int?>(json['usuarioId']),
      retiradaId: serializer.fromJson<int?>(json['retiradaId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      estoqueAnterior: serializer.fromJson<int>(json['estoqueAnterior']),
      estoquePosterior: serializer.fromJson<int>(json['estoquePosterior']),
      observacao: serializer.fromJson<String?>(json['observacao']),
      dataHora: serializer.fromJson<DateTime>(json['dataHora']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'produtoId': serializer.toJson<int>(produtoId),
      'usuarioId': serializer.toJson<int?>(usuarioId),
      'retiradaId': serializer.toJson<int?>(retiradaId),
      'tipo': serializer.toJson<String>(tipo),
      'quantidade': serializer.toJson<int>(quantidade),
      'estoqueAnterior': serializer.toJson<int>(estoqueAnterior),
      'estoquePosterior': serializer.toJson<int>(estoquePosterior),
      'observacao': serializer.toJson<String?>(observacao),
      'dataHora': serializer.toJson<DateTime>(dataHora),
    };
  }

  MovimentacoesEstoqueData copyWith({
    int? id,
    int? produtoId,
    Value<int?> usuarioId = const Value.absent(),
    Value<int?> retiradaId = const Value.absent(),
    String? tipo,
    int? quantidade,
    int? estoqueAnterior,
    int? estoquePosterior,
    Value<String?> observacao = const Value.absent(),
    DateTime? dataHora,
  }) => MovimentacoesEstoqueData(
    id: id ?? this.id,
    produtoId: produtoId ?? this.produtoId,
    usuarioId: usuarioId.present ? usuarioId.value : this.usuarioId,
    retiradaId: retiradaId.present ? retiradaId.value : this.retiradaId,
    tipo: tipo ?? this.tipo,
    quantidade: quantidade ?? this.quantidade,
    estoqueAnterior: estoqueAnterior ?? this.estoqueAnterior,
    estoquePosterior: estoquePosterior ?? this.estoquePosterior,
    observacao: observacao.present ? observacao.value : this.observacao,
    dataHora: dataHora ?? this.dataHora,
  );
  MovimentacoesEstoqueData copyWithCompanion(
    MovimentacoesEstoqueCompanion data,
  ) {
    return MovimentacoesEstoqueData(
      id: data.id.present ? data.id.value : this.id,
      produtoId: data.produtoId.present ? data.produtoId.value : this.produtoId,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      retiradaId: data.retiradaId.present
          ? data.retiradaId.value
          : this.retiradaId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      quantidade: data.quantidade.present
          ? data.quantidade.value
          : this.quantidade,
      estoqueAnterior: data.estoqueAnterior.present
          ? data.estoqueAnterior.value
          : this.estoqueAnterior,
      estoquePosterior: data.estoquePosterior.present
          ? data.estoquePosterior.value
          : this.estoquePosterior,
      observacao: data.observacao.present
          ? data.observacao.value
          : this.observacao,
      dataHora: data.dataHora.present ? data.dataHora.value : this.dataHora,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovimentacoesEstoqueData(')
          ..write('id: $id, ')
          ..write('produtoId: $produtoId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('retiradaId: $retiradaId, ')
          ..write('tipo: $tipo, ')
          ..write('quantidade: $quantidade, ')
          ..write('estoqueAnterior: $estoqueAnterior, ')
          ..write('estoquePosterior: $estoquePosterior, ')
          ..write('observacao: $observacao, ')
          ..write('dataHora: $dataHora')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    produtoId,
    usuarioId,
    retiradaId,
    tipo,
    quantidade,
    estoqueAnterior,
    estoquePosterior,
    observacao,
    dataHora,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovimentacoesEstoqueData &&
          other.id == this.id &&
          other.produtoId == this.produtoId &&
          other.usuarioId == this.usuarioId &&
          other.retiradaId == this.retiradaId &&
          other.tipo == this.tipo &&
          other.quantidade == this.quantidade &&
          other.estoqueAnterior == this.estoqueAnterior &&
          other.estoquePosterior == this.estoquePosterior &&
          other.observacao == this.observacao &&
          other.dataHora == this.dataHora);
}

class MovimentacoesEstoqueCompanion
    extends UpdateCompanion<MovimentacoesEstoqueData> {
  final Value<int> id;
  final Value<int> produtoId;
  final Value<int?> usuarioId;
  final Value<int?> retiradaId;
  final Value<String> tipo;
  final Value<int> quantidade;
  final Value<int> estoqueAnterior;
  final Value<int> estoquePosterior;
  final Value<String?> observacao;
  final Value<DateTime> dataHora;
  const MovimentacoesEstoqueCompanion({
    this.id = const Value.absent(),
    this.produtoId = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.retiradaId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.estoqueAnterior = const Value.absent(),
    this.estoquePosterior = const Value.absent(),
    this.observacao = const Value.absent(),
    this.dataHora = const Value.absent(),
  });
  MovimentacoesEstoqueCompanion.insert({
    this.id = const Value.absent(),
    required int produtoId,
    this.usuarioId = const Value.absent(),
    this.retiradaId = const Value.absent(),
    required String tipo,
    required int quantidade,
    required int estoqueAnterior,
    required int estoquePosterior,
    this.observacao = const Value.absent(),
    this.dataHora = const Value.absent(),
  }) : produtoId = Value(produtoId),
       tipo = Value(tipo),
       quantidade = Value(quantidade),
       estoqueAnterior = Value(estoqueAnterior),
       estoquePosterior = Value(estoquePosterior);
  static Insertable<MovimentacoesEstoqueData> custom({
    Expression<int>? id,
    Expression<int>? produtoId,
    Expression<int>? usuarioId,
    Expression<int>? retiradaId,
    Expression<String>? tipo,
    Expression<int>? quantidade,
    Expression<int>? estoqueAnterior,
    Expression<int>? estoquePosterior,
    Expression<String>? observacao,
    Expression<DateTime>? dataHora,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (produtoId != null) 'produto_id': produtoId,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (retiradaId != null) 'retirada_id': retiradaId,
      if (tipo != null) 'tipo': tipo,
      if (quantidade != null) 'quantidade': quantidade,
      if (estoqueAnterior != null) 'estoque_anterior': estoqueAnterior,
      if (estoquePosterior != null) 'estoque_posterior': estoquePosterior,
      if (observacao != null) 'observacao': observacao,
      if (dataHora != null) 'data_hora': dataHora,
    });
  }

  MovimentacoesEstoqueCompanion copyWith({
    Value<int>? id,
    Value<int>? produtoId,
    Value<int?>? usuarioId,
    Value<int?>? retiradaId,
    Value<String>? tipo,
    Value<int>? quantidade,
    Value<int>? estoqueAnterior,
    Value<int>? estoquePosterior,
    Value<String?>? observacao,
    Value<DateTime>? dataHora,
  }) {
    return MovimentacoesEstoqueCompanion(
      id: id ?? this.id,
      produtoId: produtoId ?? this.produtoId,
      usuarioId: usuarioId ?? this.usuarioId,
      retiradaId: retiradaId ?? this.retiradaId,
      tipo: tipo ?? this.tipo,
      quantidade: quantidade ?? this.quantidade,
      estoqueAnterior: estoqueAnterior ?? this.estoqueAnterior,
      estoquePosterior: estoquePosterior ?? this.estoquePosterior,
      observacao: observacao ?? this.observacao,
      dataHora: dataHora ?? this.dataHora,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (produtoId.present) {
      map['produto_id'] = Variable<int>(produtoId.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (retiradaId.present) {
      map['retirada_id'] = Variable<int>(retiradaId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    if (estoqueAnterior.present) {
      map['estoque_anterior'] = Variable<int>(estoqueAnterior.value);
    }
    if (estoquePosterior.present) {
      map['estoque_posterior'] = Variable<int>(estoquePosterior.value);
    }
    if (observacao.present) {
      map['observacao'] = Variable<String>(observacao.value);
    }
    if (dataHora.present) {
      map['data_hora'] = Variable<DateTime>(dataHora.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovimentacoesEstoqueCompanion(')
          ..write('id: $id, ')
          ..write('produtoId: $produtoId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('retiradaId: $retiradaId, ')
          ..write('tipo: $tipo, ')
          ..write('quantidade: $quantidade, ')
          ..write('estoqueAnterior: $estoqueAnterior, ')
          ..write('estoquePosterior: $estoquePosterior, ')
          ..write('observacao: $observacao, ')
          ..write('dataHora: $dataHora')
          ..write(')'))
        .toString();
  }
}

class $FechamentosMensaisTable extends FechamentosMensais
    with TableInfo<$FechamentosMensaisTable, FechamentosMensai> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FechamentosMensaisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mesReferenciaMeta = const VerificationMeta(
    'mesReferencia',
  );
  @override
  late final GeneratedColumn<String> mesReferencia = GeneratedColumn<String>(
    'mes_referencia',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _fechadoEmMeta = const VerificationMeta(
    'fechadoEm',
  );
  @override
  late final GeneratedColumn<DateTime> fechadoEm = GeneratedColumn<DateTime>(
    'fechado_em',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, mesReferencia, fechadoEm];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fechamentos_mensais';
  @override
  VerificationContext validateIntegrity(
    Insertable<FechamentosMensai> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mes_referencia')) {
      context.handle(
        _mesReferenciaMeta,
        mesReferencia.isAcceptableOrUnknown(
          data['mes_referencia']!,
          _mesReferenciaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mesReferenciaMeta);
    }
    if (data.containsKey('fechado_em')) {
      context.handle(
        _fechadoEmMeta,
        fechadoEm.isAcceptableOrUnknown(data['fechado_em']!, _fechadoEmMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FechamentosMensai map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FechamentosMensai(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mesReferencia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mes_referencia'],
      )!,
      fechadoEm: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fechado_em'],
      )!,
    );
  }

  @override
  $FechamentosMensaisTable createAlias(String alias) {
    return $FechamentosMensaisTable(attachedDatabase, alias);
  }
}

class FechamentosMensai extends DataClass
    implements Insertable<FechamentosMensai> {
  final int id;
  final String mesReferencia;
  final DateTime fechadoEm;
  const FechamentosMensai({
    required this.id,
    required this.mesReferencia,
    required this.fechadoEm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mes_referencia'] = Variable<String>(mesReferencia);
    map['fechado_em'] = Variable<DateTime>(fechadoEm);
    return map;
  }

  FechamentosMensaisCompanion toCompanion(bool nullToAbsent) {
    return FechamentosMensaisCompanion(
      id: Value(id),
      mesReferencia: Value(mesReferencia),
      fechadoEm: Value(fechadoEm),
    );
  }

  factory FechamentosMensai.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FechamentosMensai(
      id: serializer.fromJson<int>(json['id']),
      mesReferencia: serializer.fromJson<String>(json['mesReferencia']),
      fechadoEm: serializer.fromJson<DateTime>(json['fechadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mesReferencia': serializer.toJson<String>(mesReferencia),
      'fechadoEm': serializer.toJson<DateTime>(fechadoEm),
    };
  }

  FechamentosMensai copyWith({
    int? id,
    String? mesReferencia,
    DateTime? fechadoEm,
  }) => FechamentosMensai(
    id: id ?? this.id,
    mesReferencia: mesReferencia ?? this.mesReferencia,
    fechadoEm: fechadoEm ?? this.fechadoEm,
  );
  FechamentosMensai copyWithCompanion(FechamentosMensaisCompanion data) {
    return FechamentosMensai(
      id: data.id.present ? data.id.value : this.id,
      mesReferencia: data.mesReferencia.present
          ? data.mesReferencia.value
          : this.mesReferencia,
      fechadoEm: data.fechadoEm.present ? data.fechadoEm.value : this.fechadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FechamentosMensai(')
          ..write('id: $id, ')
          ..write('mesReferencia: $mesReferencia, ')
          ..write('fechadoEm: $fechadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mesReferencia, fechadoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FechamentosMensai &&
          other.id == this.id &&
          other.mesReferencia == this.mesReferencia &&
          other.fechadoEm == this.fechadoEm);
}

class FechamentosMensaisCompanion extends UpdateCompanion<FechamentosMensai> {
  final Value<int> id;
  final Value<String> mesReferencia;
  final Value<DateTime> fechadoEm;
  const FechamentosMensaisCompanion({
    this.id = const Value.absent(),
    this.mesReferencia = const Value.absent(),
    this.fechadoEm = const Value.absent(),
  });
  FechamentosMensaisCompanion.insert({
    this.id = const Value.absent(),
    required String mesReferencia,
    this.fechadoEm = const Value.absent(),
  }) : mesReferencia = Value(mesReferencia);
  static Insertable<FechamentosMensai> custom({
    Expression<int>? id,
    Expression<String>? mesReferencia,
    Expression<DateTime>? fechadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mesReferencia != null) 'mes_referencia': mesReferencia,
      if (fechadoEm != null) 'fechado_em': fechadoEm,
    });
  }

  FechamentosMensaisCompanion copyWith({
    Value<int>? id,
    Value<String>? mesReferencia,
    Value<DateTime>? fechadoEm,
  }) {
    return FechamentosMensaisCompanion(
      id: id ?? this.id,
      mesReferencia: mesReferencia ?? this.mesReferencia,
      fechadoEm: fechadoEm ?? this.fechadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mesReferencia.present) {
      map['mes_referencia'] = Variable<String>(mesReferencia.value);
    }
    if (fechadoEm.present) {
      map['fechado_em'] = Variable<DateTime>(fechadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FechamentosMensaisCompanion(')
          ..write('id: $id, ')
          ..write('mesReferencia: $mesReferencia, ')
          ..write('fechadoEm: $fechadoEm')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $ProdutosTable produtos = $ProdutosTable(this);
  late final $RetiradasTable retiradas = $RetiradasTable(this);
  late final $ItensRetiradaTable itensRetirada = $ItensRetiradaTable(this);
  late final $MovimentacoesEstoqueTable movimentacoesEstoque =
      $MovimentacoesEstoqueTable(this);
  late final $FechamentosMensaisTable fechamentosMensais =
      $FechamentosMensaisTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usuarios,
    produtos,
    retiradas,
    itensRetirada,
    movimentacoesEstoque,
    fechamentosMensais,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'retiradas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('itens_retirada', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'retiradas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('movimentacoes_estoque', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$UsuariosTableCreateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      required String nome,
      Value<String> tipo,
      Value<String?> pin,
      Value<bool> pinAtivo,
      Value<bool> ativo,
      Value<DateTime> criadoEm,
    });
typedef $$UsuariosTableUpdateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<String> tipo,
      Value<String?> pin,
      Value<bool> pinAtivo,
      Value<bool> ativo,
      Value<DateTime> criadoEm,
    });

final class $$UsuariosTableReferences
    extends BaseReferences<_$AppDatabase, $UsuariosTable, Usuario> {
  $$UsuariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RetiradasTable, List<Retirada>>
  _retiradasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.retiradas,
    aliasName: 'usuarios__id__retiradas__usuario_id',
  );

  $$RetiradasTableProcessedTableManager get retiradasRefs {
    final manager = $$RetiradasTableTableManager(
      $_db,
      $_db.retiradas,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_retiradasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MovimentacoesEstoqueTable,
    List<MovimentacoesEstoqueData>
  >
  _movimentacoesEstoqueRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.movimentacoesEstoque,
        aliasName: 'usuarios__id__movimentacoes_estoque__usuario_id',
      );

  $$MovimentacoesEstoqueTableProcessedTableManager
  get movimentacoesEstoqueRefs {
    final manager = $$MovimentacoesEstoqueTableTableManager(
      $_db,
      $_db.movimentacoesEstoque,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _movimentacoesEstoqueRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pin => $composableBuilder(
    column: $table.pin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pinAtivo => $composableBuilder(
    column: $table.pinAtivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get ativo => $composableBuilder(
    column: $table.ativo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> retiradasRefs(
    Expression<bool> Function($$RetiradasTableFilterComposer f) f,
  ) {
    final $$RetiradasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.retiradas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetiradasTableFilterComposer(
            $db: $db,
            $table: $db.retiradas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movimentacoesEstoqueRefs(
    Expression<bool> Function($$MovimentacoesEstoqueTableFilterComposer f) f,
  ) {
    final $$MovimentacoesEstoqueTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimentacoesEstoque,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimentacoesEstoqueTableFilterComposer(
            $db: $db,
            $table: $db.movimentacoesEstoque,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pin => $composableBuilder(
    column: $table.pin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pinAtivo => $composableBuilder(
    column: $table.pinAtivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get ativo => $composableBuilder(
    column: $table.ativo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get pin =>
      $composableBuilder(column: $table.pin, builder: (column) => column);

  GeneratedColumn<bool> get pinAtivo =>
      $composableBuilder(column: $table.pinAtivo, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  Expression<T> retiradasRefs<T extends Object>(
    Expression<T> Function($$RetiradasTableAnnotationComposer a) f,
  ) {
    final $$RetiradasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.retiradas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetiradasTableAnnotationComposer(
            $db: $db,
            $table: $db.retiradas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movimentacoesEstoqueRefs<T extends Object>(
    Expression<T> Function($$MovimentacoesEstoqueTableAnnotationComposer a) f,
  ) {
    final $$MovimentacoesEstoqueTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.movimentacoesEstoque,
          getReferencedColumn: (t) => t.usuarioId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MovimentacoesEstoqueTableAnnotationComposer(
                $db: $db,
                $table: $db.movimentacoesEstoque,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, $$UsuariosTableReferences),
          Usuario,
          PrefetchHooks Function({
            bool retiradasRefs,
            bool movimentacoesEstoqueRefs,
          })
        > {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String?> pin = const Value.absent(),
                Value<bool> pinAtivo = const Value.absent(),
                Value<bool> ativo = const Value.absent(),
                Value<DateTime> criadoEm = const Value.absent(),
              }) => UsuariosCompanion(
                id: id,
                nome: nome,
                tipo: tipo,
                pin: pin,
                pinAtivo: pinAtivo,
                ativo: ativo,
                criadoEm: criadoEm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                Value<String> tipo = const Value.absent(),
                Value<String?> pin = const Value.absent(),
                Value<bool> pinAtivo = const Value.absent(),
                Value<bool> ativo = const Value.absent(),
                Value<DateTime> criadoEm = const Value.absent(),
              }) => UsuariosCompanion.insert(
                id: id,
                nome: nome,
                tipo: tipo,
                pin: pin,
                pinAtivo: pinAtivo,
                ativo: ativo,
                criadoEm: criadoEm,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({retiradasRefs = false, movimentacoesEstoqueRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (retiradasRefs) db.retiradas,
                    if (movimentacoesEstoqueRefs) db.movimentacoesEstoque,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (retiradasRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          Retirada
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._retiradasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).retiradasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuarioId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (movimentacoesEstoqueRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          MovimentacoesEstoqueData
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._movimentacoesEstoqueRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).movimentacoesEstoqueRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuarioId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, $$UsuariosTableReferences),
      Usuario,
      PrefetchHooks Function({
        bool retiradasRefs,
        bool movimentacoesEstoqueRefs,
      })
    >;
typedef $$ProdutosTableCreateCompanionBuilder =
    ProdutosCompanion Function({
      Value<int> id,
      required String nome,
      required String categoria,
      required int precoCentavos,
      required int estoqueInicial,
      required int estoqueAtual,
      Value<String?> fotoPath,
      Value<bool> ativo,
      Value<DateTime> criadoEm,
    });
typedef $$ProdutosTableUpdateCompanionBuilder =
    ProdutosCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<String> categoria,
      Value<int> precoCentavos,
      Value<int> estoqueInicial,
      Value<int> estoqueAtual,
      Value<String?> fotoPath,
      Value<bool> ativo,
      Value<DateTime> criadoEm,
    });

final class $$ProdutosTableReferences
    extends BaseReferences<_$AppDatabase, $ProdutosTable, Produto> {
  $$ProdutosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItensRetiradaTable, List<ItensRetiradaData>>
  _itensRetiradaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.itensRetirada,
    aliasName: 'produtos__id__itens_retirada__produto_id',
  );

  $$ItensRetiradaTableProcessedTableManager get itensRetiradaRefs {
    final manager = $$ItensRetiradaTableTableManager(
      $_db,
      $_db.itensRetirada,
    ).filter((f) => f.produtoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_itensRetiradaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MovimentacoesEstoqueTable,
    List<MovimentacoesEstoqueData>
  >
  _movimentacoesEstoqueRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.movimentacoesEstoque,
        aliasName: 'produtos__id__movimentacoes_estoque__produto_id',
      );

  $$MovimentacoesEstoqueTableProcessedTableManager
  get movimentacoesEstoqueRefs {
    final manager = $$MovimentacoesEstoqueTableTableManager(
      $_db,
      $_db.movimentacoesEstoque,
    ).filter((f) => f.produtoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _movimentacoesEstoqueRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProdutosTableFilterComposer
    extends Composer<_$AppDatabase, $ProdutosTable> {
  $$ProdutosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precoCentavos => $composableBuilder(
    column: $table.precoCentavos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estoqueInicial => $composableBuilder(
    column: $table.estoqueInicial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estoqueAtual => $composableBuilder(
    column: $table.estoqueAtual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fotoPath => $composableBuilder(
    column: $table.fotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get ativo => $composableBuilder(
    column: $table.ativo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> itensRetiradaRefs(
    Expression<bool> Function($$ItensRetiradaTableFilterComposer f) f,
  ) {
    final $$ItensRetiradaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itensRetirada,
      getReferencedColumn: (t) => t.produtoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItensRetiradaTableFilterComposer(
            $db: $db,
            $table: $db.itensRetirada,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movimentacoesEstoqueRefs(
    Expression<bool> Function($$MovimentacoesEstoqueTableFilterComposer f) f,
  ) {
    final $$MovimentacoesEstoqueTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimentacoesEstoque,
      getReferencedColumn: (t) => t.produtoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimentacoesEstoqueTableFilterComposer(
            $db: $db,
            $table: $db.movimentacoesEstoque,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProdutosTableOrderingComposer
    extends Composer<_$AppDatabase, $ProdutosTable> {
  $$ProdutosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precoCentavos => $composableBuilder(
    column: $table.precoCentavos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estoqueInicial => $composableBuilder(
    column: $table.estoqueInicial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estoqueAtual => $composableBuilder(
    column: $table.estoqueAtual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fotoPath => $composableBuilder(
    column: $table.fotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get ativo => $composableBuilder(
    column: $table.ativo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProdutosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProdutosTable> {
  $$ProdutosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<int> get precoCentavos => $composableBuilder(
    column: $table.precoCentavos,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estoqueInicial => $composableBuilder(
    column: $table.estoqueInicial,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estoqueAtual => $composableBuilder(
    column: $table.estoqueAtual,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fotoPath =>
      $composableBuilder(column: $table.fotoPath, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  Expression<T> itensRetiradaRefs<T extends Object>(
    Expression<T> Function($$ItensRetiradaTableAnnotationComposer a) f,
  ) {
    final $$ItensRetiradaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itensRetirada,
      getReferencedColumn: (t) => t.produtoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItensRetiradaTableAnnotationComposer(
            $db: $db,
            $table: $db.itensRetirada,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movimentacoesEstoqueRefs<T extends Object>(
    Expression<T> Function($$MovimentacoesEstoqueTableAnnotationComposer a) f,
  ) {
    final $$MovimentacoesEstoqueTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.movimentacoesEstoque,
          getReferencedColumn: (t) => t.produtoId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MovimentacoesEstoqueTableAnnotationComposer(
                $db: $db,
                $table: $db.movimentacoesEstoque,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProdutosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProdutosTable,
          Produto,
          $$ProdutosTableFilterComposer,
          $$ProdutosTableOrderingComposer,
          $$ProdutosTableAnnotationComposer,
          $$ProdutosTableCreateCompanionBuilder,
          $$ProdutosTableUpdateCompanionBuilder,
          (Produto, $$ProdutosTableReferences),
          Produto,
          PrefetchHooks Function({
            bool itensRetiradaRefs,
            bool movimentacoesEstoqueRefs,
          })
        > {
  $$ProdutosTableTableManager(_$AppDatabase db, $ProdutosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProdutosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProdutosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProdutosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> categoria = const Value.absent(),
                Value<int> precoCentavos = const Value.absent(),
                Value<int> estoqueInicial = const Value.absent(),
                Value<int> estoqueAtual = const Value.absent(),
                Value<String?> fotoPath = const Value.absent(),
                Value<bool> ativo = const Value.absent(),
                Value<DateTime> criadoEm = const Value.absent(),
              }) => ProdutosCompanion(
                id: id,
                nome: nome,
                categoria: categoria,
                precoCentavos: precoCentavos,
                estoqueInicial: estoqueInicial,
                estoqueAtual: estoqueAtual,
                fotoPath: fotoPath,
                ativo: ativo,
                criadoEm: criadoEm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                required String categoria,
                required int precoCentavos,
                required int estoqueInicial,
                required int estoqueAtual,
                Value<String?> fotoPath = const Value.absent(),
                Value<bool> ativo = const Value.absent(),
                Value<DateTime> criadoEm = const Value.absent(),
              }) => ProdutosCompanion.insert(
                id: id,
                nome: nome,
                categoria: categoria,
                precoCentavos: precoCentavos,
                estoqueInicial: estoqueInicial,
                estoqueAtual: estoqueAtual,
                fotoPath: fotoPath,
                ativo: ativo,
                criadoEm: criadoEm,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProdutosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({itensRetiradaRefs = false, movimentacoesEstoqueRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (itensRetiradaRefs) db.itensRetirada,
                    if (movimentacoesEstoqueRefs) db.movimentacoesEstoque,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (itensRetiradaRefs)
                        await $_getPrefetchedData<
                          Produto,
                          $ProdutosTable,
                          ItensRetiradaData
                        >(
                          currentTable: table,
                          referencedTable: $$ProdutosTableReferences
                              ._itensRetiradaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProdutosTableReferences(
                                db,
                                table,
                                p0,
                              ).itensRetiradaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.produtoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (movimentacoesEstoqueRefs)
                        await $_getPrefetchedData<
                          Produto,
                          $ProdutosTable,
                          MovimentacoesEstoqueData
                        >(
                          currentTable: table,
                          referencedTable: $$ProdutosTableReferences
                              ._movimentacoesEstoqueRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProdutosTableReferences(
                                db,
                                table,
                                p0,
                              ).movimentacoesEstoqueRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.produtoId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProdutosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProdutosTable,
      Produto,
      $$ProdutosTableFilterComposer,
      $$ProdutosTableOrderingComposer,
      $$ProdutosTableAnnotationComposer,
      $$ProdutosTableCreateCompanionBuilder,
      $$ProdutosTableUpdateCompanionBuilder,
      (Produto, $$ProdutosTableReferences),
      Produto,
      PrefetchHooks Function({
        bool itensRetiradaRefs,
        bool movimentacoesEstoqueRefs,
      })
    >;
typedef $$RetiradasTableCreateCompanionBuilder =
    RetiradasCompanion Function({
      Value<int> id,
      required int usuarioId,
      required int totalCentavos,
      Value<DateTime> dataHora,
      required String mesReferencia,
      Value<bool> fechada,
    });
typedef $$RetiradasTableUpdateCompanionBuilder =
    RetiradasCompanion Function({
      Value<int> id,
      Value<int> usuarioId,
      Value<int> totalCentavos,
      Value<DateTime> dataHora,
      Value<String> mesReferencia,
      Value<bool> fechada,
    });

final class $$RetiradasTableReferences
    extends BaseReferences<_$AppDatabase, $RetiradasTable, Retirada> {
  $$RetiradasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias('retiradas__usuario_id__usuarios__id');

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<int>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ItensRetiradaTable, List<ItensRetiradaData>>
  _itensRetiradaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.itensRetirada,
    aliasName: 'retiradas__id__itens_retirada__retirada_id',
  );

  $$ItensRetiradaTableProcessedTableManager get itensRetiradaRefs {
    final manager = $$ItensRetiradaTableTableManager(
      $_db,
      $_db.itensRetirada,
    ).filter((f) => f.retiradaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_itensRetiradaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MovimentacoesEstoqueTable,
    List<MovimentacoesEstoqueData>
  >
  _movimentacoesEstoqueRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.movimentacoesEstoque,
        aliasName: 'retiradas__id__movimentacoes_estoque__retirada_id',
      );

  $$MovimentacoesEstoqueTableProcessedTableManager
  get movimentacoesEstoqueRefs {
    final manager = $$MovimentacoesEstoqueTableTableManager(
      $_db,
      $_db.movimentacoesEstoque,
    ).filter((f) => f.retiradaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _movimentacoesEstoqueRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RetiradasTableFilterComposer
    extends Composer<_$AppDatabase, $RetiradasTable> {
  $$RetiradasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCentavos => $composableBuilder(
    column: $table.totalCentavos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dataHora => $composableBuilder(
    column: $table.dataHora,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mesReferencia => $composableBuilder(
    column: $table.mesReferencia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get fechada => $composableBuilder(
    column: $table.fechada,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> itensRetiradaRefs(
    Expression<bool> Function($$ItensRetiradaTableFilterComposer f) f,
  ) {
    final $$ItensRetiradaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itensRetirada,
      getReferencedColumn: (t) => t.retiradaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItensRetiradaTableFilterComposer(
            $db: $db,
            $table: $db.itensRetirada,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movimentacoesEstoqueRefs(
    Expression<bool> Function($$MovimentacoesEstoqueTableFilterComposer f) f,
  ) {
    final $$MovimentacoesEstoqueTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimentacoesEstoque,
      getReferencedColumn: (t) => t.retiradaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimentacoesEstoqueTableFilterComposer(
            $db: $db,
            $table: $db.movimentacoesEstoque,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RetiradasTableOrderingComposer
    extends Composer<_$AppDatabase, $RetiradasTable> {
  $$RetiradasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCentavos => $composableBuilder(
    column: $table.totalCentavos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dataHora => $composableBuilder(
    column: $table.dataHora,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mesReferencia => $composableBuilder(
    column: $table.mesReferencia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get fechada => $composableBuilder(
    column: $table.fechada,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RetiradasTableAnnotationComposer
    extends Composer<_$AppDatabase, $RetiradasTable> {
  $$RetiradasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalCentavos => $composableBuilder(
    column: $table.totalCentavos,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dataHora =>
      $composableBuilder(column: $table.dataHora, builder: (column) => column);

  GeneratedColumn<String> get mesReferencia => $composableBuilder(
    column: $table.mesReferencia,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get fechada =>
      $composableBuilder(column: $table.fechada, builder: (column) => column);

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> itensRetiradaRefs<T extends Object>(
    Expression<T> Function($$ItensRetiradaTableAnnotationComposer a) f,
  ) {
    final $$ItensRetiradaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itensRetirada,
      getReferencedColumn: (t) => t.retiradaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItensRetiradaTableAnnotationComposer(
            $db: $db,
            $table: $db.itensRetirada,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movimentacoesEstoqueRefs<T extends Object>(
    Expression<T> Function($$MovimentacoesEstoqueTableAnnotationComposer a) f,
  ) {
    final $$MovimentacoesEstoqueTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.movimentacoesEstoque,
          getReferencedColumn: (t) => t.retiradaId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MovimentacoesEstoqueTableAnnotationComposer(
                $db: $db,
                $table: $db.movimentacoesEstoque,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RetiradasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RetiradasTable,
          Retirada,
          $$RetiradasTableFilterComposer,
          $$RetiradasTableOrderingComposer,
          $$RetiradasTableAnnotationComposer,
          $$RetiradasTableCreateCompanionBuilder,
          $$RetiradasTableUpdateCompanionBuilder,
          (Retirada, $$RetiradasTableReferences),
          Retirada,
          PrefetchHooks Function({
            bool usuarioId,
            bool itensRetiradaRefs,
            bool movimentacoesEstoqueRefs,
          })
        > {
  $$RetiradasTableTableManager(_$AppDatabase db, $RetiradasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RetiradasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RetiradasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RetiradasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> usuarioId = const Value.absent(),
                Value<int> totalCentavos = const Value.absent(),
                Value<DateTime> dataHora = const Value.absent(),
                Value<String> mesReferencia = const Value.absent(),
                Value<bool> fechada = const Value.absent(),
              }) => RetiradasCompanion(
                id: id,
                usuarioId: usuarioId,
                totalCentavos: totalCentavos,
                dataHora: dataHora,
                mesReferencia: mesReferencia,
                fechada: fechada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int usuarioId,
                required int totalCentavos,
                Value<DateTime> dataHora = const Value.absent(),
                required String mesReferencia,
                Value<bool> fechada = const Value.absent(),
              }) => RetiradasCompanion.insert(
                id: id,
                usuarioId: usuarioId,
                totalCentavos: totalCentavos,
                dataHora: dataHora,
                mesReferencia: mesReferencia,
                fechada: fechada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RetiradasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                usuarioId = false,
                itensRetiradaRefs = false,
                movimentacoesEstoqueRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (itensRetiradaRefs) db.itensRetirada,
                    if (movimentacoesEstoqueRefs) db.movimentacoesEstoque,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (usuarioId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.usuarioId,
                                    referencedTable: $$RetiradasTableReferences
                                        ._usuarioIdTable(db),
                                    referencedColumn: $$RetiradasTableReferences
                                        ._usuarioIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (itensRetiradaRefs)
                        await $_getPrefetchedData<
                          Retirada,
                          $RetiradasTable,
                          ItensRetiradaData
                        >(
                          currentTable: table,
                          referencedTable: $$RetiradasTableReferences
                              ._itensRetiradaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RetiradasTableReferences(
                                db,
                                table,
                                p0,
                              ).itensRetiradaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.retiradaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (movimentacoesEstoqueRefs)
                        await $_getPrefetchedData<
                          Retirada,
                          $RetiradasTable,
                          MovimentacoesEstoqueData
                        >(
                          currentTable: table,
                          referencedTable: $$RetiradasTableReferences
                              ._movimentacoesEstoqueRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RetiradasTableReferences(
                                db,
                                table,
                                p0,
                              ).movimentacoesEstoqueRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.retiradaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RetiradasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RetiradasTable,
      Retirada,
      $$RetiradasTableFilterComposer,
      $$RetiradasTableOrderingComposer,
      $$RetiradasTableAnnotationComposer,
      $$RetiradasTableCreateCompanionBuilder,
      $$RetiradasTableUpdateCompanionBuilder,
      (Retirada, $$RetiradasTableReferences),
      Retirada,
      PrefetchHooks Function({
        bool usuarioId,
        bool itensRetiradaRefs,
        bool movimentacoesEstoqueRefs,
      })
    >;
typedef $$ItensRetiradaTableCreateCompanionBuilder =
    ItensRetiradaCompanion Function({
      Value<int> id,
      required int retiradaId,
      required int produtoId,
      required String nomeProduto,
      required int quantidade,
      required int precoUnitarioCentavos,
      required int subtotalCentavos,
    });
typedef $$ItensRetiradaTableUpdateCompanionBuilder =
    ItensRetiradaCompanion Function({
      Value<int> id,
      Value<int> retiradaId,
      Value<int> produtoId,
      Value<String> nomeProduto,
      Value<int> quantidade,
      Value<int> precoUnitarioCentavos,
      Value<int> subtotalCentavos,
    });

final class $$ItensRetiradaTableReferences
    extends
        BaseReferences<_$AppDatabase, $ItensRetiradaTable, ItensRetiradaData> {
  $$ItensRetiradaTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RetiradasTable _retiradaIdTable(_$AppDatabase db) =>
      db.retiradas.createAlias('itens_retirada__retirada_id__retiradas__id');

  $$RetiradasTableProcessedTableManager get retiradaId {
    final $_column = $_itemColumn<int>('retirada_id')!;

    final manager = $$RetiradasTableTableManager(
      $_db,
      $_db.retiradas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_retiradaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProdutosTable _produtoIdTable(_$AppDatabase db) =>
      db.produtos.createAlias('itens_retirada__produto_id__produtos__id');

  $$ProdutosTableProcessedTableManager get produtoId {
    final $_column = $_itemColumn<int>('produto_id')!;

    final manager = $$ProdutosTableTableManager(
      $_db,
      $_db.produtos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_produtoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ItensRetiradaTableFilterComposer
    extends Composer<_$AppDatabase, $ItensRetiradaTable> {
  $$ItensRetiradaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nomeProduto => $composableBuilder(
    column: $table.nomeProduto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantidade => $composableBuilder(
    column: $table.quantidade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precoUnitarioCentavos => $composableBuilder(
    column: $table.precoUnitarioCentavos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotalCentavos => $composableBuilder(
    column: $table.subtotalCentavos,
    builder: (column) => ColumnFilters(column),
  );

  $$RetiradasTableFilterComposer get retiradaId {
    final $$RetiradasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retiradaId,
      referencedTable: $db.retiradas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetiradasTableFilterComposer(
            $db: $db,
            $table: $db.retiradas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProdutosTableFilterComposer get produtoId {
    final $$ProdutosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.produtoId,
      referencedTable: $db.produtos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdutosTableFilterComposer(
            $db: $db,
            $table: $db.produtos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItensRetiradaTableOrderingComposer
    extends Composer<_$AppDatabase, $ItensRetiradaTable> {
  $$ItensRetiradaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nomeProduto => $composableBuilder(
    column: $table.nomeProduto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantidade => $composableBuilder(
    column: $table.quantidade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precoUnitarioCentavos => $composableBuilder(
    column: $table.precoUnitarioCentavos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotalCentavos => $composableBuilder(
    column: $table.subtotalCentavos,
    builder: (column) => ColumnOrderings(column),
  );

  $$RetiradasTableOrderingComposer get retiradaId {
    final $$RetiradasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retiradaId,
      referencedTable: $db.retiradas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetiradasTableOrderingComposer(
            $db: $db,
            $table: $db.retiradas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProdutosTableOrderingComposer get produtoId {
    final $$ProdutosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.produtoId,
      referencedTable: $db.produtos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdutosTableOrderingComposer(
            $db: $db,
            $table: $db.produtos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItensRetiradaTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItensRetiradaTable> {
  $$ItensRetiradaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nomeProduto => $composableBuilder(
    column: $table.nomeProduto,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantidade => $composableBuilder(
    column: $table.quantidade,
    builder: (column) => column,
  );

  GeneratedColumn<int> get precoUnitarioCentavos => $composableBuilder(
    column: $table.precoUnitarioCentavos,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotalCentavos => $composableBuilder(
    column: $table.subtotalCentavos,
    builder: (column) => column,
  );

  $$RetiradasTableAnnotationComposer get retiradaId {
    final $$RetiradasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retiradaId,
      referencedTable: $db.retiradas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetiradasTableAnnotationComposer(
            $db: $db,
            $table: $db.retiradas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProdutosTableAnnotationComposer get produtoId {
    final $$ProdutosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.produtoId,
      referencedTable: $db.produtos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdutosTableAnnotationComposer(
            $db: $db,
            $table: $db.produtos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItensRetiradaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItensRetiradaTable,
          ItensRetiradaData,
          $$ItensRetiradaTableFilterComposer,
          $$ItensRetiradaTableOrderingComposer,
          $$ItensRetiradaTableAnnotationComposer,
          $$ItensRetiradaTableCreateCompanionBuilder,
          $$ItensRetiradaTableUpdateCompanionBuilder,
          (ItensRetiradaData, $$ItensRetiradaTableReferences),
          ItensRetiradaData,
          PrefetchHooks Function({bool retiradaId, bool produtoId})
        > {
  $$ItensRetiradaTableTableManager(_$AppDatabase db, $ItensRetiradaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItensRetiradaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItensRetiradaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItensRetiradaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> retiradaId = const Value.absent(),
                Value<int> produtoId = const Value.absent(),
                Value<String> nomeProduto = const Value.absent(),
                Value<int> quantidade = const Value.absent(),
                Value<int> precoUnitarioCentavos = const Value.absent(),
                Value<int> subtotalCentavos = const Value.absent(),
              }) => ItensRetiradaCompanion(
                id: id,
                retiradaId: retiradaId,
                produtoId: produtoId,
                nomeProduto: nomeProduto,
                quantidade: quantidade,
                precoUnitarioCentavos: precoUnitarioCentavos,
                subtotalCentavos: subtotalCentavos,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int retiradaId,
                required int produtoId,
                required String nomeProduto,
                required int quantidade,
                required int precoUnitarioCentavos,
                required int subtotalCentavos,
              }) => ItensRetiradaCompanion.insert(
                id: id,
                retiradaId: retiradaId,
                produtoId: produtoId,
                nomeProduto: nomeProduto,
                quantidade: quantidade,
                precoUnitarioCentavos: precoUnitarioCentavos,
                subtotalCentavos: subtotalCentavos,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ItensRetiradaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({retiradaId = false, produtoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (retiradaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.retiradaId,
                                referencedTable: $$ItensRetiradaTableReferences
                                    ._retiradaIdTable(db),
                                referencedColumn: $$ItensRetiradaTableReferences
                                    ._retiradaIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (produtoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.produtoId,
                                referencedTable: $$ItensRetiradaTableReferences
                                    ._produtoIdTable(db),
                                referencedColumn: $$ItensRetiradaTableReferences
                                    ._produtoIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ItensRetiradaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItensRetiradaTable,
      ItensRetiradaData,
      $$ItensRetiradaTableFilterComposer,
      $$ItensRetiradaTableOrderingComposer,
      $$ItensRetiradaTableAnnotationComposer,
      $$ItensRetiradaTableCreateCompanionBuilder,
      $$ItensRetiradaTableUpdateCompanionBuilder,
      (ItensRetiradaData, $$ItensRetiradaTableReferences),
      ItensRetiradaData,
      PrefetchHooks Function({bool retiradaId, bool produtoId})
    >;
typedef $$MovimentacoesEstoqueTableCreateCompanionBuilder =
    MovimentacoesEstoqueCompanion Function({
      Value<int> id,
      required int produtoId,
      Value<int?> usuarioId,
      Value<int?> retiradaId,
      required String tipo,
      required int quantidade,
      required int estoqueAnterior,
      required int estoquePosterior,
      Value<String?> observacao,
      Value<DateTime> dataHora,
    });
typedef $$MovimentacoesEstoqueTableUpdateCompanionBuilder =
    MovimentacoesEstoqueCompanion Function({
      Value<int> id,
      Value<int> produtoId,
      Value<int?> usuarioId,
      Value<int?> retiradaId,
      Value<String> tipo,
      Value<int> quantidade,
      Value<int> estoqueAnterior,
      Value<int> estoquePosterior,
      Value<String?> observacao,
      Value<DateTime> dataHora,
    });

final class $$MovimentacoesEstoqueTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MovimentacoesEstoqueTable,
          MovimentacoesEstoqueData
        > {
  $$MovimentacoesEstoqueTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProdutosTable _produtoIdTable(_$AppDatabase db) => db.produtos
      .createAlias('movimentacoes_estoque__produto_id__produtos__id');

  $$ProdutosTableProcessedTableManager get produtoId {
    final $_column = $_itemColumn<int>('produto_id')!;

    final manager = $$ProdutosTableTableManager(
      $_db,
      $_db.produtos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_produtoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) => db.usuarios
      .createAlias('movimentacoes_estoque__usuario_id__usuarios__id');

  $$UsuariosTableProcessedTableManager? get usuarioId {
    final $_column = $_itemColumn<int>('usuario_id');
    if ($_column == null) return null;
    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RetiradasTable _retiradaIdTable(_$AppDatabase db) => db.retiradas
      .createAlias('movimentacoes_estoque__retirada_id__retiradas__id');

  $$RetiradasTableProcessedTableManager? get retiradaId {
    final $_column = $_itemColumn<int>('retirada_id');
    if ($_column == null) return null;
    final manager = $$RetiradasTableTableManager(
      $_db,
      $_db.retiradas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_retiradaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MovimentacoesEstoqueTableFilterComposer
    extends Composer<_$AppDatabase, $MovimentacoesEstoqueTable> {
  $$MovimentacoesEstoqueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantidade => $composableBuilder(
    column: $table.quantidade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estoqueAnterior => $composableBuilder(
    column: $table.estoqueAnterior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estoquePosterior => $composableBuilder(
    column: $table.estoquePosterior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observacao => $composableBuilder(
    column: $table.observacao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dataHora => $composableBuilder(
    column: $table.dataHora,
    builder: (column) => ColumnFilters(column),
  );

  $$ProdutosTableFilterComposer get produtoId {
    final $$ProdutosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.produtoId,
      referencedTable: $db.produtos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdutosTableFilterComposer(
            $db: $db,
            $table: $db.produtos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RetiradasTableFilterComposer get retiradaId {
    final $$RetiradasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retiradaId,
      referencedTable: $db.retiradas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetiradasTableFilterComposer(
            $db: $db,
            $table: $db.retiradas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimentacoesEstoqueTableOrderingComposer
    extends Composer<_$AppDatabase, $MovimentacoesEstoqueTable> {
  $$MovimentacoesEstoqueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantidade => $composableBuilder(
    column: $table.quantidade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estoqueAnterior => $composableBuilder(
    column: $table.estoqueAnterior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estoquePosterior => $composableBuilder(
    column: $table.estoquePosterior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observacao => $composableBuilder(
    column: $table.observacao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dataHora => $composableBuilder(
    column: $table.dataHora,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProdutosTableOrderingComposer get produtoId {
    final $$ProdutosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.produtoId,
      referencedTable: $db.produtos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdutosTableOrderingComposer(
            $db: $db,
            $table: $db.produtos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RetiradasTableOrderingComposer get retiradaId {
    final $$RetiradasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retiradaId,
      referencedTable: $db.retiradas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetiradasTableOrderingComposer(
            $db: $db,
            $table: $db.retiradas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimentacoesEstoqueTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovimentacoesEstoqueTable> {
  $$MovimentacoesEstoqueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<int> get quantidade => $composableBuilder(
    column: $table.quantidade,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estoqueAnterior => $composableBuilder(
    column: $table.estoqueAnterior,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estoquePosterior => $composableBuilder(
    column: $table.estoquePosterior,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observacao => $composableBuilder(
    column: $table.observacao,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dataHora =>
      $composableBuilder(column: $table.dataHora, builder: (column) => column);

  $$ProdutosTableAnnotationComposer get produtoId {
    final $$ProdutosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.produtoId,
      referencedTable: $db.produtos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdutosTableAnnotationComposer(
            $db: $db,
            $table: $db.produtos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RetiradasTableAnnotationComposer get retiradaId {
    final $$RetiradasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retiradaId,
      referencedTable: $db.retiradas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetiradasTableAnnotationComposer(
            $db: $db,
            $table: $db.retiradas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimentacoesEstoqueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovimentacoesEstoqueTable,
          MovimentacoesEstoqueData,
          $$MovimentacoesEstoqueTableFilterComposer,
          $$MovimentacoesEstoqueTableOrderingComposer,
          $$MovimentacoesEstoqueTableAnnotationComposer,
          $$MovimentacoesEstoqueTableCreateCompanionBuilder,
          $$MovimentacoesEstoqueTableUpdateCompanionBuilder,
          (MovimentacoesEstoqueData, $$MovimentacoesEstoqueTableReferences),
          MovimentacoesEstoqueData,
          PrefetchHooks Function({
            bool produtoId,
            bool usuarioId,
            bool retiradaId,
          })
        > {
  $$MovimentacoesEstoqueTableTableManager(
    _$AppDatabase db,
    $MovimentacoesEstoqueTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovimentacoesEstoqueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovimentacoesEstoqueTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MovimentacoesEstoqueTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> produtoId = const Value.absent(),
                Value<int?> usuarioId = const Value.absent(),
                Value<int?> retiradaId = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<int> quantidade = const Value.absent(),
                Value<int> estoqueAnterior = const Value.absent(),
                Value<int> estoquePosterior = const Value.absent(),
                Value<String?> observacao = const Value.absent(),
                Value<DateTime> dataHora = const Value.absent(),
              }) => MovimentacoesEstoqueCompanion(
                id: id,
                produtoId: produtoId,
                usuarioId: usuarioId,
                retiradaId: retiradaId,
                tipo: tipo,
                quantidade: quantidade,
                estoqueAnterior: estoqueAnterior,
                estoquePosterior: estoquePosterior,
                observacao: observacao,
                dataHora: dataHora,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int produtoId,
                Value<int?> usuarioId = const Value.absent(),
                Value<int?> retiradaId = const Value.absent(),
                required String tipo,
                required int quantidade,
                required int estoqueAnterior,
                required int estoquePosterior,
                Value<String?> observacao = const Value.absent(),
                Value<DateTime> dataHora = const Value.absent(),
              }) => MovimentacoesEstoqueCompanion.insert(
                id: id,
                produtoId: produtoId,
                usuarioId: usuarioId,
                retiradaId: retiradaId,
                tipo: tipo,
                quantidade: quantidade,
                estoqueAnterior: estoqueAnterior,
                estoquePosterior: estoquePosterior,
                observacao: observacao,
                dataHora: dataHora,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MovimentacoesEstoqueTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({produtoId = false, usuarioId = false, retiradaId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (produtoId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.produtoId,
                                    referencedTable:
                                        $$MovimentacoesEstoqueTableReferences
                                            ._produtoIdTable(db),
                                    referencedColumn:
                                        $$MovimentacoesEstoqueTableReferences
                                            ._produtoIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (usuarioId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.usuarioId,
                                    referencedTable:
                                        $$MovimentacoesEstoqueTableReferences
                                            ._usuarioIdTable(db),
                                    referencedColumn:
                                        $$MovimentacoesEstoqueTableReferences
                                            ._usuarioIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (retiradaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.retiradaId,
                                    referencedTable:
                                        $$MovimentacoesEstoqueTableReferences
                                            ._retiradaIdTable(db),
                                    referencedColumn:
                                        $$MovimentacoesEstoqueTableReferences
                                            ._retiradaIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$MovimentacoesEstoqueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovimentacoesEstoqueTable,
      MovimentacoesEstoqueData,
      $$MovimentacoesEstoqueTableFilterComposer,
      $$MovimentacoesEstoqueTableOrderingComposer,
      $$MovimentacoesEstoqueTableAnnotationComposer,
      $$MovimentacoesEstoqueTableCreateCompanionBuilder,
      $$MovimentacoesEstoqueTableUpdateCompanionBuilder,
      (MovimentacoesEstoqueData, $$MovimentacoesEstoqueTableReferences),
      MovimentacoesEstoqueData,
      PrefetchHooks Function({bool produtoId, bool usuarioId, bool retiradaId})
    >;
typedef $$FechamentosMensaisTableCreateCompanionBuilder =
    FechamentosMensaisCompanion Function({
      Value<int> id,
      required String mesReferencia,
      Value<DateTime> fechadoEm,
    });
typedef $$FechamentosMensaisTableUpdateCompanionBuilder =
    FechamentosMensaisCompanion Function({
      Value<int> id,
      Value<String> mesReferencia,
      Value<DateTime> fechadoEm,
    });

class $$FechamentosMensaisTableFilterComposer
    extends Composer<_$AppDatabase, $FechamentosMensaisTable> {
  $$FechamentosMensaisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mesReferencia => $composableBuilder(
    column: $table.mesReferencia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechadoEm => $composableBuilder(
    column: $table.fechadoEm,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FechamentosMensaisTableOrderingComposer
    extends Composer<_$AppDatabase, $FechamentosMensaisTable> {
  $$FechamentosMensaisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mesReferencia => $composableBuilder(
    column: $table.mesReferencia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechadoEm => $composableBuilder(
    column: $table.fechadoEm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FechamentosMensaisTableAnnotationComposer
    extends Composer<_$AppDatabase, $FechamentosMensaisTable> {
  $$FechamentosMensaisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mesReferencia => $composableBuilder(
    column: $table.mesReferencia,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechadoEm =>
      $composableBuilder(column: $table.fechadoEm, builder: (column) => column);
}

class $$FechamentosMensaisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FechamentosMensaisTable,
          FechamentosMensai,
          $$FechamentosMensaisTableFilterComposer,
          $$FechamentosMensaisTableOrderingComposer,
          $$FechamentosMensaisTableAnnotationComposer,
          $$FechamentosMensaisTableCreateCompanionBuilder,
          $$FechamentosMensaisTableUpdateCompanionBuilder,
          (
            FechamentosMensai,
            BaseReferences<
              _$AppDatabase,
              $FechamentosMensaisTable,
              FechamentosMensai
            >,
          ),
          FechamentosMensai,
          PrefetchHooks Function()
        > {
  $$FechamentosMensaisTableTableManager(
    _$AppDatabase db,
    $FechamentosMensaisTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FechamentosMensaisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FechamentosMensaisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FechamentosMensaisTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> mesReferencia = const Value.absent(),
                Value<DateTime> fechadoEm = const Value.absent(),
              }) => FechamentosMensaisCompanion(
                id: id,
                mesReferencia: mesReferencia,
                fechadoEm: fechadoEm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String mesReferencia,
                Value<DateTime> fechadoEm = const Value.absent(),
              }) => FechamentosMensaisCompanion.insert(
                id: id,
                mesReferencia: mesReferencia,
                fechadoEm: fechadoEm,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FechamentosMensaisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FechamentosMensaisTable,
      FechamentosMensai,
      $$FechamentosMensaisTableFilterComposer,
      $$FechamentosMensaisTableOrderingComposer,
      $$FechamentosMensaisTableAnnotationComposer,
      $$FechamentosMensaisTableCreateCompanionBuilder,
      $$FechamentosMensaisTableUpdateCompanionBuilder,
      (
        FechamentosMensai,
        BaseReferences<
          _$AppDatabase,
          $FechamentosMensaisTable,
          FechamentosMensai
        >,
      ),
      FechamentosMensai,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$ProdutosTableTableManager get produtos =>
      $$ProdutosTableTableManager(_db, _db.produtos);
  $$RetiradasTableTableManager get retiradas =>
      $$RetiradasTableTableManager(_db, _db.retiradas);
  $$ItensRetiradaTableTableManager get itensRetirada =>
      $$ItensRetiradaTableTableManager(_db, _db.itensRetirada);
  $$MovimentacoesEstoqueTableTableManager get movimentacoesEstoque =>
      $$MovimentacoesEstoqueTableTableManager(_db, _db.movimentacoesEstoque);
  $$FechamentosMensaisTableTableManager get fechamentosMensais =>
      $$FechamentosMensaisTableTableManager(_db, _db.fechamentosMensais);
}
