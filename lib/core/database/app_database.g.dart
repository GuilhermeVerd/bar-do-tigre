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
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('oficial'));
  static const VerificationMeta _pinMeta = const VerificationMeta('pin');
  @override
  late final GeneratedColumn<String> pin = GeneratedColumn<String>(
      'pin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pinAtivoMeta =
      const VerificationMeta('pinAtivo');
  @override
  late final GeneratedColumn<bool> pinAtivo = GeneratedColumn<bool>(
      'pin_ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("pin_ativo" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nome, tipo, pin, pinAtivo, ativo, criadoEm];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(Insertable<Usuario> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    }
    if (data.containsKey('pin')) {
      context.handle(
          _pinMeta, pin.isAcceptableOrUnknown(data['pin']!, _pinMeta));
    }
    if (data.containsKey('pin_ativo')) {
      context.handle(_pinAtivoMeta,
          pinAtivo.isAcceptableOrUnknown(data['pin_ativo']!, _pinAtivoMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      pin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pin']),
      pinAtivo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pin_ativo'])!,
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
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
  const Usuario(
      {required this.id,
      required this.nome,
      required this.tipo,
      this.pin,
      required this.pinAtivo,
      required this.ativo,
      required this.criadoEm});
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

  factory Usuario.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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

  Usuario copyWith(
          {int? id,
          String? nome,
          String? tipo,
          Value<String?> pin = const Value.absent(),
          bool? pinAtivo,
          bool? ativo,
          DateTime? criadoEm}) =>
      Usuario(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        tipo: tipo ?? this.tipo,
        pin: pin.present ? pin.value : this.pin,
        pinAtivo: pinAtivo ?? this.pinAtivo,
        ativo: ativo ?? this.ativo,
        criadoEm: criadoEm ?? this.criadoEm,
      );
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

  UsuariosCompanion copyWith(
      {Value<int>? id,
      Value<String>? nome,
      Value<String>? tipo,
      Value<String?>? pin,
      Value<bool>? pinAtivo,
      Value<bool>? ativo,
      Value<DateTime>? criadoEm}) {
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
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _precoCentavosMeta =
      const VerificationMeta('precoCentavos');
  @override
  late final GeneratedColumn<int> precoCentavos = GeneratedColumn<int>(
      'preco_centavos', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _estoqueInicialMeta =
      const VerificationMeta('estoqueInicial');
  @override
  late final GeneratedColumn<int> estoqueInicial = GeneratedColumn<int>(
      'estoque_inicial', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _estoqueAtualMeta =
      const VerificationMeta('estoqueAtual');
  @override
  late final GeneratedColumn<int> estoqueAtual = GeneratedColumn<int>(
      'estoque_atual', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fotoPathMeta =
      const VerificationMeta('fotoPath');
  @override
  late final GeneratedColumn<String> fotoPath = GeneratedColumn<String>(
      'foto_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
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
        criadoEm
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'produtos';
  @override
  VerificationContext validateIntegrity(Insertable<Produto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    if (data.containsKey('preco_centavos')) {
      context.handle(
          _precoCentavosMeta,
          precoCentavos.isAcceptableOrUnknown(
              data['preco_centavos']!, _precoCentavosMeta));
    } else if (isInserting) {
      context.missing(_precoCentavosMeta);
    }
    if (data.containsKey('estoque_inicial')) {
      context.handle(
          _estoqueInicialMeta,
          estoqueInicial.isAcceptableOrUnknown(
              data['estoque_inicial']!, _estoqueInicialMeta));
    } else if (isInserting) {
      context.missing(_estoqueInicialMeta);
    }
    if (data.containsKey('estoque_atual')) {
      context.handle(
          _estoqueAtualMeta,
          estoqueAtual.isAcceptableOrUnknown(
              data['estoque_atual']!, _estoqueAtualMeta));
    } else if (isInserting) {
      context.missing(_estoqueAtualMeta);
    }
    if (data.containsKey('foto_path')) {
      context.handle(_fotoPathMeta,
          fotoPath.isAcceptableOrUnknown(data['foto_path']!, _fotoPathMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Produto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Produto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria'])!,
      precoCentavos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}preco_centavos'])!,
      estoqueInicial: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estoque_inicial'])!,
      estoqueAtual: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estoque_atual'])!,
      fotoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}foto_path']),
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
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
  const Produto(
      {required this.id,
      required this.nome,
      required this.categoria,
      required this.precoCentavos,
      required this.estoqueInicial,
      required this.estoqueAtual,
      this.fotoPath,
      required this.ativo,
      required this.criadoEm});
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

  factory Produto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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

  Produto copyWith(
          {int? id,
          String? nome,
          String? categoria,
          int? precoCentavos,
          int? estoqueInicial,
          int? estoqueAtual,
          Value<String?> fotoPath = const Value.absent(),
          bool? ativo,
          DateTime? criadoEm}) =>
      Produto(
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
  int get hashCode => Object.hash(id, nome, categoria, precoCentavos,
      estoqueInicial, estoqueAtual, fotoPath, ativo, criadoEm);
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
  })  : nome = Value(nome),
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

  ProdutosCompanion copyWith(
      {Value<int>? id,
      Value<String>? nome,
      Value<String>? categoria,
      Value<int>? precoCentavos,
      Value<int>? estoqueInicial,
      Value<int>? estoqueAtual,
      Value<String?>? fotoPath,
      Value<bool>? ativo,
      Value<DateTime>? criadoEm}) {
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
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usuarioIdMeta =
      const VerificationMeta('usuarioId');
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
      'usuario_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuarios (id)'));
  static const VerificationMeta _totalCentavosMeta =
      const VerificationMeta('totalCentavos');
  @override
  late final GeneratedColumn<int> totalCentavos = GeneratedColumn<int>(
      'total_centavos', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dataHoraMeta =
      const VerificationMeta('dataHora');
  @override
  late final GeneratedColumn<DateTime> dataHora = GeneratedColumn<DateTime>(
      'data_hora', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _mesReferenciaMeta =
      const VerificationMeta('mesReferencia');
  @override
  late final GeneratedColumn<String> mesReferencia = GeneratedColumn<String>(
      'mes_referencia', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechadaMeta =
      const VerificationMeta('fechada');
  @override
  late final GeneratedColumn<bool> fechada = GeneratedColumn<bool>(
      'fechada', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("fechada" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, usuarioId, totalCentavos, dataHora, mesReferencia, fechada];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'retiradas';
  @override
  VerificationContext validateIntegrity(Insertable<Retirada> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(_usuarioIdMeta,
          usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta));
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('total_centavos')) {
      context.handle(
          _totalCentavosMeta,
          totalCentavos.isAcceptableOrUnknown(
              data['total_centavos']!, _totalCentavosMeta));
    } else if (isInserting) {
      context.missing(_totalCentavosMeta);
    }
    if (data.containsKey('data_hora')) {
      context.handle(_dataHoraMeta,
          dataHora.isAcceptableOrUnknown(data['data_hora']!, _dataHoraMeta));
    }
    if (data.containsKey('mes_referencia')) {
      context.handle(
          _mesReferenciaMeta,
          mesReferencia.isAcceptableOrUnknown(
              data['mes_referencia']!, _mesReferenciaMeta));
    } else if (isInserting) {
      context.missing(_mesReferenciaMeta);
    }
    if (data.containsKey('fechada')) {
      context.handle(_fechadaMeta,
          fechada.isAcceptableOrUnknown(data['fechada']!, _fechadaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Retirada map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Retirada(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      usuarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usuario_id'])!,
      totalCentavos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_centavos'])!,
      dataHora: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_hora'])!,
      mesReferencia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mes_referencia'])!,
      fechada: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}fechada'])!,
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
  const Retirada(
      {required this.id,
      required this.usuarioId,
      required this.totalCentavos,
      required this.dataHora,
      required this.mesReferencia,
      required this.fechada});
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

  factory Retirada.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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

  Retirada copyWith(
          {int? id,
          int? usuarioId,
          int? totalCentavos,
          DateTime? dataHora,
          String? mesReferencia,
          bool? fechada}) =>
      Retirada(
        id: id ?? this.id,
        usuarioId: usuarioId ?? this.usuarioId,
        totalCentavos: totalCentavos ?? this.totalCentavos,
        dataHora: dataHora ?? this.dataHora,
        mesReferencia: mesReferencia ?? this.mesReferencia,
        fechada: fechada ?? this.fechada,
      );
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
      id, usuarioId, totalCentavos, dataHora, mesReferencia, fechada);
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
  })  : usuarioId = Value(usuarioId),
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

  RetiradasCompanion copyWith(
      {Value<int>? id,
      Value<int>? usuarioId,
      Value<int>? totalCentavos,
      Value<DateTime>? dataHora,
      Value<String>? mesReferencia,
      Value<bool>? fechada}) {
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
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _retiradaIdMeta =
      const VerificationMeta('retiradaId');
  @override
  late final GeneratedColumn<int> retiradaId = GeneratedColumn<int>(
      'retirada_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES retiradas (id) ON DELETE CASCADE'));
  static const VerificationMeta _produtoIdMeta =
      const VerificationMeta('produtoId');
  @override
  late final GeneratedColumn<int> produtoId = GeneratedColumn<int>(
      'produto_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES produtos (id)'));
  static const VerificationMeta _nomeProdutoMeta =
      const VerificationMeta('nomeProduto');
  @override
  late final GeneratedColumn<String> nomeProduto = GeneratedColumn<String>(
      'nome_produto', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantidadeMeta =
      const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _precoUnitarioCentavosMeta =
      const VerificationMeta('precoUnitarioCentavos');
  @override
  late final GeneratedColumn<int> precoUnitarioCentavos = GeneratedColumn<int>(
      'preco_unitario_centavos', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _subtotalCentavosMeta =
      const VerificationMeta('subtotalCentavos');
  @override
  late final GeneratedColumn<int> subtotalCentavos = GeneratedColumn<int>(
      'subtotal_centavos', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        retiradaId,
        produtoId,
        nomeProduto,
        quantidade,
        precoUnitarioCentavos,
        subtotalCentavos
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'itens_retirada';
  @override
  VerificationContext validateIntegrity(Insertable<ItensRetiradaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('retirada_id')) {
      context.handle(
          _retiradaIdMeta,
          retiradaId.isAcceptableOrUnknown(
              data['retirada_id']!, _retiradaIdMeta));
    } else if (isInserting) {
      context.missing(_retiradaIdMeta);
    }
    if (data.containsKey('produto_id')) {
      context.handle(_produtoIdMeta,
          produtoId.isAcceptableOrUnknown(data['produto_id']!, _produtoIdMeta));
    } else if (isInserting) {
      context.missing(_produtoIdMeta);
    }
    if (data.containsKey('nome_produto')) {
      context.handle(
          _nomeProdutoMeta,
          nomeProduto.isAcceptableOrUnknown(
              data['nome_produto']!, _nomeProdutoMeta));
    } else if (isInserting) {
      context.missing(_nomeProdutoMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('preco_unitario_centavos')) {
      context.handle(
          _precoUnitarioCentavosMeta,
          precoUnitarioCentavos.isAcceptableOrUnknown(
              data['preco_unitario_centavos']!, _precoUnitarioCentavosMeta));
    } else if (isInserting) {
      context.missing(_precoUnitarioCentavosMeta);
    }
    if (data.containsKey('subtotal_centavos')) {
      context.handle(
          _subtotalCentavosMeta,
          subtotalCentavos.isAcceptableOrUnknown(
              data['subtotal_centavos']!, _subtotalCentavosMeta));
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
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      retiradaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retirada_id'])!,
      produtoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}produto_id'])!,
      nomeProduto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_produto'])!,
      quantidade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
      precoUnitarioCentavos: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}preco_unitario_centavos'])!,
      subtotalCentavos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subtotal_centavos'])!,
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
  const ItensRetiradaData(
      {required this.id,
      required this.retiradaId,
      required this.produtoId,
      required this.nomeProduto,
      required this.quantidade,
      required this.precoUnitarioCentavos,
      required this.subtotalCentavos});
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

  factory ItensRetiradaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItensRetiradaData(
      id: serializer.fromJson<int>(json['id']),
      retiradaId: serializer.fromJson<int>(json['retiradaId']),
      produtoId: serializer.fromJson<int>(json['produtoId']),
      nomeProduto: serializer.fromJson<String>(json['nomeProduto']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      precoUnitarioCentavos:
          serializer.fromJson<int>(json['precoUnitarioCentavos']),
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

  ItensRetiradaData copyWith(
          {int? id,
          int? retiradaId,
          int? produtoId,
          String? nomeProduto,
          int? quantidade,
          int? precoUnitarioCentavos,
          int? subtotalCentavos}) =>
      ItensRetiradaData(
        id: id ?? this.id,
        retiradaId: retiradaId ?? this.retiradaId,
        produtoId: produtoId ?? this.produtoId,
        nomeProduto: nomeProduto ?? this.nomeProduto,
        quantidade: quantidade ?? this.quantidade,
        precoUnitarioCentavos:
            precoUnitarioCentavos ?? this.precoUnitarioCentavos,
        subtotalCentavos: subtotalCentavos ?? this.subtotalCentavos,
      );
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
  int get hashCode => Object.hash(id, retiradaId, produtoId, nomeProduto,
      quantidade, precoUnitarioCentavos, subtotalCentavos);
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
  })  : retiradaId = Value(retiradaId),
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

  ItensRetiradaCompanion copyWith(
      {Value<int>? id,
      Value<int>? retiradaId,
      Value<int>? produtoId,
      Value<String>? nomeProduto,
      Value<int>? quantidade,
      Value<int>? precoUnitarioCentavos,
      Value<int>? subtotalCentavos}) {
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
      map['preco_unitario_centavos'] =
          Variable<int>(precoUnitarioCentavos.value);
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
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _produtoIdMeta =
      const VerificationMeta('produtoId');
  @override
  late final GeneratedColumn<int> produtoId = GeneratedColumn<int>(
      'produto_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES produtos (id)'));
  static const VerificationMeta _usuarioIdMeta =
      const VerificationMeta('usuarioId');
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
      'usuario_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuarios (id)'));
  static const VerificationMeta _retiradaIdMeta =
      const VerificationMeta('retiradaId');
  @override
  late final GeneratedColumn<int> retiradaId = GeneratedColumn<int>(
      'retirada_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES retiradas (id) ON DELETE SET NULL'));
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _quantidadeMeta =
      const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _estoqueAnteriorMeta =
      const VerificationMeta('estoqueAnterior');
  @override
  late final GeneratedColumn<int> estoqueAnterior = GeneratedColumn<int>(
      'estoque_anterior', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _estoquePosteriorMeta =
      const VerificationMeta('estoquePosterior');
  @override
  late final GeneratedColumn<int> estoquePosterior = GeneratedColumn<int>(
      'estoque_posterior', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
      'observacao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dataHoraMeta =
      const VerificationMeta('dataHora');
  @override
  late final GeneratedColumn<DateTime> dataHora = GeneratedColumn<DateTime>(
      'data_hora', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
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
        dataHora
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movimentacoes_estoque';
  @override
  VerificationContext validateIntegrity(
      Insertable<MovimentacoesEstoqueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('produto_id')) {
      context.handle(_produtoIdMeta,
          produtoId.isAcceptableOrUnknown(data['produto_id']!, _produtoIdMeta));
    } else if (isInserting) {
      context.missing(_produtoIdMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(_usuarioIdMeta,
          usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta));
    }
    if (data.containsKey('retirada_id')) {
      context.handle(
          _retiradaIdMeta,
          retiradaId.isAcceptableOrUnknown(
              data['retirada_id']!, _retiradaIdMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('estoque_anterior')) {
      context.handle(
          _estoqueAnteriorMeta,
          estoqueAnterior.isAcceptableOrUnknown(
              data['estoque_anterior']!, _estoqueAnteriorMeta));
    } else if (isInserting) {
      context.missing(_estoqueAnteriorMeta);
    }
    if (data.containsKey('estoque_posterior')) {
      context.handle(
          _estoquePosteriorMeta,
          estoquePosterior.isAcceptableOrUnknown(
              data['estoque_posterior']!, _estoquePosteriorMeta));
    } else if (isInserting) {
      context.missing(_estoquePosteriorMeta);
    }
    if (data.containsKey('observacao')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['observacao']!, _observacaoMeta));
    }
    if (data.containsKey('data_hora')) {
      context.handle(_dataHoraMeta,
          dataHora.isAcceptableOrUnknown(data['data_hora']!, _dataHoraMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovimentacoesEstoqueData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovimentacoesEstoqueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      produtoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}produto_id'])!,
      usuarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usuario_id']),
      retiradaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retirada_id']),
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      quantidade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
      estoqueAnterior: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estoque_anterior'])!,
      estoquePosterior: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estoque_posterior'])!,
      observacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacao']),
      dataHora: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_hora'])!,
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
  const MovimentacoesEstoqueData(
      {required this.id,
      required this.produtoId,
      this.usuarioId,
      this.retiradaId,
      required this.tipo,
      required this.quantidade,
      required this.estoqueAnterior,
      required this.estoquePosterior,
      this.observacao,
      required this.dataHora});
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

  factory MovimentacoesEstoqueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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

  MovimentacoesEstoqueData copyWith(
          {int? id,
          int? produtoId,
          Value<int?> usuarioId = const Value.absent(),
          Value<int?> retiradaId = const Value.absent(),
          String? tipo,
          int? quantidade,
          int? estoqueAnterior,
          int? estoquePosterior,
          Value<String?> observacao = const Value.absent(),
          DateTime? dataHora}) =>
      MovimentacoesEstoqueData(
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
  int get hashCode => Object.hash(id, produtoId, usuarioId, retiradaId, tipo,
      quantidade, estoqueAnterior, estoquePosterior, observacao, dataHora);
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
  })  : produtoId = Value(produtoId),
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

  MovimentacoesEstoqueCompanion copyWith(
      {Value<int>? id,
      Value<int>? produtoId,
      Value<int?>? usuarioId,
      Value<int?>? retiradaId,
      Value<String>? tipo,
      Value<int>? quantidade,
      Value<int>? estoqueAnterior,
      Value<int>? estoquePosterior,
      Value<String?>? observacao,
      Value<DateTime>? dataHora}) {
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
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _mesReferenciaMeta =
      const VerificationMeta('mesReferencia');
  @override
  late final GeneratedColumn<String> mesReferencia = GeneratedColumn<String>(
      'mes_referencia', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _fechadoEmMeta =
      const VerificationMeta('fechadoEm');
  @override
  late final GeneratedColumn<DateTime> fechadoEm = GeneratedColumn<DateTime>(
      'fechado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, mesReferencia, fechadoEm];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fechamentos_mensais';
  @override
  VerificationContext validateIntegrity(Insertable<FechamentosMensai> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mes_referencia')) {
      context.handle(
          _mesReferenciaMeta,
          mesReferencia.isAcceptableOrUnknown(
              data['mes_referencia']!, _mesReferenciaMeta));
    } else if (isInserting) {
      context.missing(_mesReferenciaMeta);
    }
    if (data.containsKey('fechado_em')) {
      context.handle(_fechadoEmMeta,
          fechadoEm.isAcceptableOrUnknown(data['fechado_em']!, _fechadoEmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FechamentosMensai map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FechamentosMensai(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      mesReferencia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mes_referencia'])!,
      fechadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fechado_em'])!,
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
  const FechamentosMensai(
      {required this.id, required this.mesReferencia, required this.fechadoEm});
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

  factory FechamentosMensai.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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

  FechamentosMensai copyWith(
          {int? id, String? mesReferencia, DateTime? fechadoEm}) =>
      FechamentosMensai(
        id: id ?? this.id,
        mesReferencia: mesReferencia ?? this.mesReferencia,
        fechadoEm: fechadoEm ?? this.fechadoEm,
      );
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

  FechamentosMensaisCompanion copyWith(
      {Value<int>? id,
      Value<String>? mesReferencia,
      Value<DateTime>? fechadoEm}) {
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

class $PagamentosMensaisTable extends PagamentosMensais
    with TableInfo<$PagamentosMensaisTable, PagamentosMensai> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PagamentosMensaisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usuarioIdMeta =
      const VerificationMeta('usuarioId');
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
      'usuario_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuarios (id)'));
  static const VerificationMeta _mesReferenciaMeta =
      const VerificationMeta('mesReferencia');
  @override
  late final GeneratedColumn<String> mesReferencia = GeneratedColumn<String>(
      'mes_referencia', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valorCentavosMeta =
      const VerificationMeta('valorCentavos');
  @override
  late final GeneratedColumn<int> valorCentavos = GeneratedColumn<int>(
      'valor_centavos', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pagoEmMeta = const VerificationMeta('pagoEm');
  @override
  late final GeneratedColumn<DateTime> pagoEm = GeneratedColumn<DateTime>(
      'pago_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, usuarioId, mesReferencia, valorCentavos, pagoEm];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pagamentos_mensais';
  @override
  VerificationContext validateIntegrity(Insertable<PagamentosMensai> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(_usuarioIdMeta,
          usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta));
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('mes_referencia')) {
      context.handle(
          _mesReferenciaMeta,
          mesReferencia.isAcceptableOrUnknown(
              data['mes_referencia']!, _mesReferenciaMeta));
    } else if (isInserting) {
      context.missing(_mesReferenciaMeta);
    }
    if (data.containsKey('valor_centavos')) {
      context.handle(
          _valorCentavosMeta,
          valorCentavos.isAcceptableOrUnknown(
              data['valor_centavos']!, _valorCentavosMeta));
    } else if (isInserting) {
      context.missing(_valorCentavosMeta);
    }
    if (data.containsKey('pago_em')) {
      context.handle(_pagoEmMeta,
          pagoEm.isAcceptableOrUnknown(data['pago_em']!, _pagoEmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {usuarioId, mesReferencia},
      ];
  @override
  PagamentosMensai map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PagamentosMensai(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      usuarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usuario_id'])!,
      mesReferencia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mes_referencia'])!,
      valorCentavos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}valor_centavos'])!,
      pagoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}pago_em'])!,
    );
  }

  @override
  $PagamentosMensaisTable createAlias(String alias) {
    return $PagamentosMensaisTable(attachedDatabase, alias);
  }
}

class PagamentosMensai extends DataClass
    implements Insertable<PagamentosMensai> {
  final int id;
  final int usuarioId;
  final String mesReferencia;
  final int valorCentavos;
  final DateTime pagoEm;
  const PagamentosMensai(
      {required this.id,
      required this.usuarioId,
      required this.mesReferencia,
      required this.valorCentavos,
      required this.pagoEm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<int>(usuarioId);
    map['mes_referencia'] = Variable<String>(mesReferencia);
    map['valor_centavos'] = Variable<int>(valorCentavos);
    map['pago_em'] = Variable<DateTime>(pagoEm);
    return map;
  }

  PagamentosMensaisCompanion toCompanion(bool nullToAbsent) {
    return PagamentosMensaisCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      mesReferencia: Value(mesReferencia),
      valorCentavos: Value(valorCentavos),
      pagoEm: Value(pagoEm),
    );
  }

  factory PagamentosMensai.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PagamentosMensai(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      mesReferencia: serializer.fromJson<String>(json['mesReferencia']),
      valorCentavos: serializer.fromJson<int>(json['valorCentavos']),
      pagoEm: serializer.fromJson<DateTime>(json['pagoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'mesReferencia': serializer.toJson<String>(mesReferencia),
      'valorCentavos': serializer.toJson<int>(valorCentavos),
      'pagoEm': serializer.toJson<DateTime>(pagoEm),
    };
  }

  PagamentosMensai copyWith(
          {int? id,
          int? usuarioId,
          String? mesReferencia,
          int? valorCentavos,
          DateTime? pagoEm}) =>
      PagamentosMensai(
        id: id ?? this.id,
        usuarioId: usuarioId ?? this.usuarioId,
        mesReferencia: mesReferencia ?? this.mesReferencia,
        valorCentavos: valorCentavos ?? this.valorCentavos,
        pagoEm: pagoEm ?? this.pagoEm,
      );
  @override
  String toString() {
    return (StringBuffer('PagamentosMensai(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('mesReferencia: $mesReferencia, ')
          ..write('valorCentavos: $valorCentavos, ')
          ..write('pagoEm: $pagoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, usuarioId, mesReferencia, valorCentavos, pagoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PagamentosMensai &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.mesReferencia == this.mesReferencia &&
          other.valorCentavos == this.valorCentavos &&
          other.pagoEm == this.pagoEm);
}

class PagamentosMensaisCompanion extends UpdateCompanion<PagamentosMensai> {
  final Value<int> id;
  final Value<int> usuarioId;
  final Value<String> mesReferencia;
  final Value<int> valorCentavos;
  final Value<DateTime> pagoEm;
  const PagamentosMensaisCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.mesReferencia = const Value.absent(),
    this.valorCentavos = const Value.absent(),
    this.pagoEm = const Value.absent(),
  });
  PagamentosMensaisCompanion.insert({
    this.id = const Value.absent(),
    required int usuarioId,
    required String mesReferencia,
    required int valorCentavos,
    this.pagoEm = const Value.absent(),
  })  : usuarioId = Value(usuarioId),
        mesReferencia = Value(mesReferencia),
        valorCentavos = Value(valorCentavos);
  static Insertable<PagamentosMensai> custom({
    Expression<int>? id,
    Expression<int>? usuarioId,
    Expression<String>? mesReferencia,
    Expression<int>? valorCentavos,
    Expression<DateTime>? pagoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (mesReferencia != null) 'mes_referencia': mesReferencia,
      if (valorCentavos != null) 'valor_centavos': valorCentavos,
      if (pagoEm != null) 'pago_em': pagoEm,
    });
  }

  PagamentosMensaisCompanion copyWith(
      {Value<int>? id,
      Value<int>? usuarioId,
      Value<String>? mesReferencia,
      Value<int>? valorCentavos,
      Value<DateTime>? pagoEm}) {
    return PagamentosMensaisCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      mesReferencia: mesReferencia ?? this.mesReferencia,
      valorCentavos: valorCentavos ?? this.valorCentavos,
      pagoEm: pagoEm ?? this.pagoEm,
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
    if (mesReferencia.present) {
      map['mes_referencia'] = Variable<String>(mesReferencia.value);
    }
    if (valorCentavos.present) {
      map['valor_centavos'] = Variable<int>(valorCentavos.value);
    }
    if (pagoEm.present) {
      map['pago_em'] = Variable<DateTime>(pagoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PagamentosMensaisCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('mesReferencia: $mesReferencia, ')
          ..write('valorCentavos: $valorCentavos, ')
          ..write('pagoEm: $pagoEm')
          ..write(')'))
        .toString();
  }
}

class $InventariosTable extends Inventarios
    with TableInfo<$InventariosTable, Inventario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dataHoraMeta =
      const VerificationMeta('dataHora');
  @override
  late final GeneratedColumn<DateTime> dataHora = GeneratedColumn<DateTime>(
      'data_hora', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _responsavelMeta =
      const VerificationMeta('responsavel');
  @override
  late final GeneratedColumn<String> responsavel = GeneratedColumn<String>(
      'responsavel', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _quantidadeProdutosMeta =
      const VerificationMeta('quantidadeProdutos');
  @override
  late final GeneratedColumn<int> quantidadeProdutos = GeneratedColumn<int>(
      'quantidade_produtos', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quantidadeDiferencasMeta =
      const VerificationMeta('quantidadeDiferencas');
  @override
  late final GeneratedColumn<int> quantidadeDiferencas = GeneratedColumn<int>(
      'quantidade_diferencas', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
      'observacao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        dataHora,
        responsavel,
        quantidadeProdutos,
        quantidadeDiferencas,
        observacao
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventarios';
  @override
  VerificationContext validateIntegrity(Insertable<Inventario> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data_hora')) {
      context.handle(_dataHoraMeta,
          dataHora.isAcceptableOrUnknown(data['data_hora']!, _dataHoraMeta));
    }
    if (data.containsKey('responsavel')) {
      context.handle(
          _responsavelMeta,
          responsavel.isAcceptableOrUnknown(
              data['responsavel']!, _responsavelMeta));
    } else if (isInserting) {
      context.missing(_responsavelMeta);
    }
    if (data.containsKey('quantidade_produtos')) {
      context.handle(
          _quantidadeProdutosMeta,
          quantidadeProdutos.isAcceptableOrUnknown(
              data['quantidade_produtos']!, _quantidadeProdutosMeta));
    } else if (isInserting) {
      context.missing(_quantidadeProdutosMeta);
    }
    if (data.containsKey('quantidade_diferencas')) {
      context.handle(
          _quantidadeDiferencasMeta,
          quantidadeDiferencas.isAcceptableOrUnknown(
              data['quantidade_diferencas']!, _quantidadeDiferencasMeta));
    } else if (isInserting) {
      context.missing(_quantidadeDiferencasMeta);
    }
    if (data.containsKey('observacao')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['observacao']!, _observacaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Inventario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Inventario(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dataHora: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_hora'])!,
      responsavel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}responsavel'])!,
      quantidadeProdutos: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}quantidade_produtos'])!,
      quantidadeDiferencas: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}quantidade_diferencas'])!,
      observacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacao']),
    );
  }

  @override
  $InventariosTable createAlias(String alias) {
    return $InventariosTable(attachedDatabase, alias);
  }
}

class Inventario extends DataClass implements Insertable<Inventario> {
  final int id;
  final DateTime dataHora;
  final String responsavel;
  final int quantidadeProdutos;
  final int quantidadeDiferencas;
  final String? observacao;
  const Inventario(
      {required this.id,
      required this.dataHora,
      required this.responsavel,
      required this.quantidadeProdutos,
      required this.quantidadeDiferencas,
      this.observacao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['data_hora'] = Variable<DateTime>(dataHora);
    map['responsavel'] = Variable<String>(responsavel);
    map['quantidade_produtos'] = Variable<int>(quantidadeProdutos);
    map['quantidade_diferencas'] = Variable<int>(quantidadeDiferencas);
    if (!nullToAbsent || observacao != null) {
      map['observacao'] = Variable<String>(observacao);
    }
    return map;
  }

  InventariosCompanion toCompanion(bool nullToAbsent) {
    return InventariosCompanion(
      id: Value(id),
      dataHora: Value(dataHora),
      responsavel: Value(responsavel),
      quantidadeProdutos: Value(quantidadeProdutos),
      quantidadeDiferencas: Value(quantidadeDiferencas),
      observacao: observacao == null && nullToAbsent
          ? const Value.absent()
          : Value(observacao),
    );
  }

  factory Inventario.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Inventario(
      id: serializer.fromJson<int>(json['id']),
      dataHora: serializer.fromJson<DateTime>(json['dataHora']),
      responsavel: serializer.fromJson<String>(json['responsavel']),
      quantidadeProdutos: serializer.fromJson<int>(json['quantidadeProdutos']),
      quantidadeDiferencas:
          serializer.fromJson<int>(json['quantidadeDiferencas']),
      observacao: serializer.fromJson<String?>(json['observacao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dataHora': serializer.toJson<DateTime>(dataHora),
      'responsavel': serializer.toJson<String>(responsavel),
      'quantidadeProdutos': serializer.toJson<int>(quantidadeProdutos),
      'quantidadeDiferencas': serializer.toJson<int>(quantidadeDiferencas),
      'observacao': serializer.toJson<String?>(observacao),
    };
  }

  Inventario copyWith(
          {int? id,
          DateTime? dataHora,
          String? responsavel,
          int? quantidadeProdutos,
          int? quantidadeDiferencas,
          Value<String?> observacao = const Value.absent()}) =>
      Inventario(
        id: id ?? this.id,
        dataHora: dataHora ?? this.dataHora,
        responsavel: responsavel ?? this.responsavel,
        quantidadeProdutos: quantidadeProdutos ?? this.quantidadeProdutos,
        quantidadeDiferencas: quantidadeDiferencas ?? this.quantidadeDiferencas,
        observacao: observacao.present ? observacao.value : this.observacao,
      );
  @override
  String toString() {
    return (StringBuffer('Inventario(')
          ..write('id: $id, ')
          ..write('dataHora: $dataHora, ')
          ..write('responsavel: $responsavel, ')
          ..write('quantidadeProdutos: $quantidadeProdutos, ')
          ..write('quantidadeDiferencas: $quantidadeDiferencas, ')
          ..write('observacao: $observacao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dataHora, responsavel, quantidadeProdutos,
      quantidadeDiferencas, observacao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Inventario &&
          other.id == this.id &&
          other.dataHora == this.dataHora &&
          other.responsavel == this.responsavel &&
          other.quantidadeProdutos == this.quantidadeProdutos &&
          other.quantidadeDiferencas == this.quantidadeDiferencas &&
          other.observacao == this.observacao);
}

class InventariosCompanion extends UpdateCompanion<Inventario> {
  final Value<int> id;
  final Value<DateTime> dataHora;
  final Value<String> responsavel;
  final Value<int> quantidadeProdutos;
  final Value<int> quantidadeDiferencas;
  final Value<String?> observacao;
  const InventariosCompanion({
    this.id = const Value.absent(),
    this.dataHora = const Value.absent(),
    this.responsavel = const Value.absent(),
    this.quantidadeProdutos = const Value.absent(),
    this.quantidadeDiferencas = const Value.absent(),
    this.observacao = const Value.absent(),
  });
  InventariosCompanion.insert({
    this.id = const Value.absent(),
    this.dataHora = const Value.absent(),
    required String responsavel,
    required int quantidadeProdutos,
    required int quantidadeDiferencas,
    this.observacao = const Value.absent(),
  })  : responsavel = Value(responsavel),
        quantidadeProdutos = Value(quantidadeProdutos),
        quantidadeDiferencas = Value(quantidadeDiferencas);
  static Insertable<Inventario> custom({
    Expression<int>? id,
    Expression<DateTime>? dataHora,
    Expression<String>? responsavel,
    Expression<int>? quantidadeProdutos,
    Expression<int>? quantidadeDiferencas,
    Expression<String>? observacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dataHora != null) 'data_hora': dataHora,
      if (responsavel != null) 'responsavel': responsavel,
      if (quantidadeProdutos != null) 'quantidade_produtos': quantidadeProdutos,
      if (quantidadeDiferencas != null)
        'quantidade_diferencas': quantidadeDiferencas,
      if (observacao != null) 'observacao': observacao,
    });
  }

  InventariosCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? dataHora,
      Value<String>? responsavel,
      Value<int>? quantidadeProdutos,
      Value<int>? quantidadeDiferencas,
      Value<String?>? observacao}) {
    return InventariosCompanion(
      id: id ?? this.id,
      dataHora: dataHora ?? this.dataHora,
      responsavel: responsavel ?? this.responsavel,
      quantidadeProdutos: quantidadeProdutos ?? this.quantidadeProdutos,
      quantidadeDiferencas: quantidadeDiferencas ?? this.quantidadeDiferencas,
      observacao: observacao ?? this.observacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dataHora.present) {
      map['data_hora'] = Variable<DateTime>(dataHora.value);
    }
    if (responsavel.present) {
      map['responsavel'] = Variable<String>(responsavel.value);
    }
    if (quantidadeProdutos.present) {
      map['quantidade_produtos'] = Variable<int>(quantidadeProdutos.value);
    }
    if (quantidadeDiferencas.present) {
      map['quantidade_diferencas'] = Variable<int>(quantidadeDiferencas.value);
    }
    if (observacao.present) {
      map['observacao'] = Variable<String>(observacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventariosCompanion(')
          ..write('id: $id, ')
          ..write('dataHora: $dataHora, ')
          ..write('responsavel: $responsavel, ')
          ..write('quantidadeProdutos: $quantidadeProdutos, ')
          ..write('quantidadeDiferencas: $quantidadeDiferencas, ')
          ..write('observacao: $observacao')
          ..write(')'))
        .toString();
  }
}

class $ItensInventarioTable extends ItensInventario
    with TableInfo<$ItensInventarioTable, ItensInventarioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItensInventarioTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _inventarioIdMeta =
      const VerificationMeta('inventarioId');
  @override
  late final GeneratedColumn<int> inventarioId = GeneratedColumn<int>(
      'inventario_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES inventarios (id) ON DELETE CASCADE'));
  static const VerificationMeta _produtoIdMeta =
      const VerificationMeta('produtoId');
  @override
  late final GeneratedColumn<int> produtoId = GeneratedColumn<int>(
      'produto_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES produtos (id)'));
  static const VerificationMeta _nomeProdutoMeta =
      const VerificationMeta('nomeProduto');
  @override
  late final GeneratedColumn<String> nomeProduto = GeneratedColumn<String>(
      'nome_produto', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estoqueSistemaMeta =
      const VerificationMeta('estoqueSistema');
  @override
  late final GeneratedColumn<int> estoqueSistema = GeneratedColumn<int>(
      'estoque_sistema', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _estoqueContadoMeta =
      const VerificationMeta('estoqueContado');
  @override
  late final GeneratedColumn<int> estoqueContado = GeneratedColumn<int>(
      'estoque_contado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _diferencaMeta =
      const VerificationMeta('diferenca');
  @override
  late final GeneratedColumn<int> diferenca = GeneratedColumn<int>(
      'diferenca', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        inventarioId,
        produtoId,
        nomeProduto,
        estoqueSistema,
        estoqueContado,
        diferenca
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'itens_inventario';
  @override
  VerificationContext validateIntegrity(
      Insertable<ItensInventarioData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('inventario_id')) {
      context.handle(
          _inventarioIdMeta,
          inventarioId.isAcceptableOrUnknown(
              data['inventario_id']!, _inventarioIdMeta));
    } else if (isInserting) {
      context.missing(_inventarioIdMeta);
    }
    if (data.containsKey('produto_id')) {
      context.handle(_produtoIdMeta,
          produtoId.isAcceptableOrUnknown(data['produto_id']!, _produtoIdMeta));
    } else if (isInserting) {
      context.missing(_produtoIdMeta);
    }
    if (data.containsKey('nome_produto')) {
      context.handle(
          _nomeProdutoMeta,
          nomeProduto.isAcceptableOrUnknown(
              data['nome_produto']!, _nomeProdutoMeta));
    } else if (isInserting) {
      context.missing(_nomeProdutoMeta);
    }
    if (data.containsKey('estoque_sistema')) {
      context.handle(
          _estoqueSistemaMeta,
          estoqueSistema.isAcceptableOrUnknown(
              data['estoque_sistema']!, _estoqueSistemaMeta));
    } else if (isInserting) {
      context.missing(_estoqueSistemaMeta);
    }
    if (data.containsKey('estoque_contado')) {
      context.handle(
          _estoqueContadoMeta,
          estoqueContado.isAcceptableOrUnknown(
              data['estoque_contado']!, _estoqueContadoMeta));
    } else if (isInserting) {
      context.missing(_estoqueContadoMeta);
    }
    if (data.containsKey('diferenca')) {
      context.handle(_diferencaMeta,
          diferenca.isAcceptableOrUnknown(data['diferenca']!, _diferencaMeta));
    } else if (isInserting) {
      context.missing(_diferencaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItensInventarioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItensInventarioData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      inventarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}inventario_id'])!,
      produtoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}produto_id'])!,
      nomeProduto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_produto'])!,
      estoqueSistema: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estoque_sistema'])!,
      estoqueContado: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estoque_contado'])!,
      diferenca: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diferenca'])!,
    );
  }

  @override
  $ItensInventarioTable createAlias(String alias) {
    return $ItensInventarioTable(attachedDatabase, alias);
  }
}

class ItensInventarioData extends DataClass
    implements Insertable<ItensInventarioData> {
  final int id;
  final int inventarioId;
  final int produtoId;
  final String nomeProduto;
  final int estoqueSistema;
  final int estoqueContado;
  final int diferenca;
  const ItensInventarioData(
      {required this.id,
      required this.inventarioId,
      required this.produtoId,
      required this.nomeProduto,
      required this.estoqueSistema,
      required this.estoqueContado,
      required this.diferenca});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['inventario_id'] = Variable<int>(inventarioId);
    map['produto_id'] = Variable<int>(produtoId);
    map['nome_produto'] = Variable<String>(nomeProduto);
    map['estoque_sistema'] = Variable<int>(estoqueSistema);
    map['estoque_contado'] = Variable<int>(estoqueContado);
    map['diferenca'] = Variable<int>(diferenca);
    return map;
  }

  ItensInventarioCompanion toCompanion(bool nullToAbsent) {
    return ItensInventarioCompanion(
      id: Value(id),
      inventarioId: Value(inventarioId),
      produtoId: Value(produtoId),
      nomeProduto: Value(nomeProduto),
      estoqueSistema: Value(estoqueSistema),
      estoqueContado: Value(estoqueContado),
      diferenca: Value(diferenca),
    );
  }

  factory ItensInventarioData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItensInventarioData(
      id: serializer.fromJson<int>(json['id']),
      inventarioId: serializer.fromJson<int>(json['inventarioId']),
      produtoId: serializer.fromJson<int>(json['produtoId']),
      nomeProduto: serializer.fromJson<String>(json['nomeProduto']),
      estoqueSistema: serializer.fromJson<int>(json['estoqueSistema']),
      estoqueContado: serializer.fromJson<int>(json['estoqueContado']),
      diferenca: serializer.fromJson<int>(json['diferenca']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'inventarioId': serializer.toJson<int>(inventarioId),
      'produtoId': serializer.toJson<int>(produtoId),
      'nomeProduto': serializer.toJson<String>(nomeProduto),
      'estoqueSistema': serializer.toJson<int>(estoqueSistema),
      'estoqueContado': serializer.toJson<int>(estoqueContado),
      'diferenca': serializer.toJson<int>(diferenca),
    };
  }

  ItensInventarioData copyWith(
          {int? id,
          int? inventarioId,
          int? produtoId,
          String? nomeProduto,
          int? estoqueSistema,
          int? estoqueContado,
          int? diferenca}) =>
      ItensInventarioData(
        id: id ?? this.id,
        inventarioId: inventarioId ?? this.inventarioId,
        produtoId: produtoId ?? this.produtoId,
        nomeProduto: nomeProduto ?? this.nomeProduto,
        estoqueSistema: estoqueSistema ?? this.estoqueSistema,
        estoqueContado: estoqueContado ?? this.estoqueContado,
        diferenca: diferenca ?? this.diferenca,
      );
  @override
  String toString() {
    return (StringBuffer('ItensInventarioData(')
          ..write('id: $id, ')
          ..write('inventarioId: $inventarioId, ')
          ..write('produtoId: $produtoId, ')
          ..write('nomeProduto: $nomeProduto, ')
          ..write('estoqueSistema: $estoqueSistema, ')
          ..write('estoqueContado: $estoqueContado, ')
          ..write('diferenca: $diferenca')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, inventarioId, produtoId, nomeProduto,
      estoqueSistema, estoqueContado, diferenca);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItensInventarioData &&
          other.id == this.id &&
          other.inventarioId == this.inventarioId &&
          other.produtoId == this.produtoId &&
          other.nomeProduto == this.nomeProduto &&
          other.estoqueSistema == this.estoqueSistema &&
          other.estoqueContado == this.estoqueContado &&
          other.diferenca == this.diferenca);
}

class ItensInventarioCompanion extends UpdateCompanion<ItensInventarioData> {
  final Value<int> id;
  final Value<int> inventarioId;
  final Value<int> produtoId;
  final Value<String> nomeProduto;
  final Value<int> estoqueSistema;
  final Value<int> estoqueContado;
  final Value<int> diferenca;
  const ItensInventarioCompanion({
    this.id = const Value.absent(),
    this.inventarioId = const Value.absent(),
    this.produtoId = const Value.absent(),
    this.nomeProduto = const Value.absent(),
    this.estoqueSistema = const Value.absent(),
    this.estoqueContado = const Value.absent(),
    this.diferenca = const Value.absent(),
  });
  ItensInventarioCompanion.insert({
    this.id = const Value.absent(),
    required int inventarioId,
    required int produtoId,
    required String nomeProduto,
    required int estoqueSistema,
    required int estoqueContado,
    required int diferenca,
  })  : inventarioId = Value(inventarioId),
        produtoId = Value(produtoId),
        nomeProduto = Value(nomeProduto),
        estoqueSistema = Value(estoqueSistema),
        estoqueContado = Value(estoqueContado),
        diferenca = Value(diferenca);
  static Insertable<ItensInventarioData> custom({
    Expression<int>? id,
    Expression<int>? inventarioId,
    Expression<int>? produtoId,
    Expression<String>? nomeProduto,
    Expression<int>? estoqueSistema,
    Expression<int>? estoqueContado,
    Expression<int>? diferenca,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inventarioId != null) 'inventario_id': inventarioId,
      if (produtoId != null) 'produto_id': produtoId,
      if (nomeProduto != null) 'nome_produto': nomeProduto,
      if (estoqueSistema != null) 'estoque_sistema': estoqueSistema,
      if (estoqueContado != null) 'estoque_contado': estoqueContado,
      if (diferenca != null) 'diferenca': diferenca,
    });
  }

  ItensInventarioCompanion copyWith(
      {Value<int>? id,
      Value<int>? inventarioId,
      Value<int>? produtoId,
      Value<String>? nomeProduto,
      Value<int>? estoqueSistema,
      Value<int>? estoqueContado,
      Value<int>? diferenca}) {
    return ItensInventarioCompanion(
      id: id ?? this.id,
      inventarioId: inventarioId ?? this.inventarioId,
      produtoId: produtoId ?? this.produtoId,
      nomeProduto: nomeProduto ?? this.nomeProduto,
      estoqueSistema: estoqueSistema ?? this.estoqueSistema,
      estoqueContado: estoqueContado ?? this.estoqueContado,
      diferenca: diferenca ?? this.diferenca,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (inventarioId.present) {
      map['inventario_id'] = Variable<int>(inventarioId.value);
    }
    if (produtoId.present) {
      map['produto_id'] = Variable<int>(produtoId.value);
    }
    if (nomeProduto.present) {
      map['nome_produto'] = Variable<String>(nomeProduto.value);
    }
    if (estoqueSistema.present) {
      map['estoque_sistema'] = Variable<int>(estoqueSistema.value);
    }
    if (estoqueContado.present) {
      map['estoque_contado'] = Variable<int>(estoqueContado.value);
    }
    if (diferenca.present) {
      map['diferenca'] = Variable<int>(diferenca.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItensInventarioCompanion(')
          ..write('id: $id, ')
          ..write('inventarioId: $inventarioId, ')
          ..write('produtoId: $produtoId, ')
          ..write('nomeProduto: $nomeProduto, ')
          ..write('estoqueSistema: $estoqueSistema, ')
          ..write('estoqueContado: $estoqueContado, ')
          ..write('diferenca: $diferenca')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $ProdutosTable produtos = $ProdutosTable(this);
  late final $RetiradasTable retiradas = $RetiradasTable(this);
  late final $ItensRetiradaTable itensRetirada = $ItensRetiradaTable(this);
  late final $MovimentacoesEstoqueTable movimentacoesEstoque =
      $MovimentacoesEstoqueTable(this);
  late final $FechamentosMensaisTable fechamentosMensais =
      $FechamentosMensaisTable(this);
  late final $PagamentosMensaisTable pagamentosMensais =
      $PagamentosMensaisTable(this);
  late final $InventariosTable inventarios = $InventariosTable(this);
  late final $ItensInventarioTable itensInventario =
      $ItensInventarioTable(this);
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
        pagamentosMensais,
        inventarios,
        itensInventario
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('retiradas',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('itens_retirada', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('retiradas',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('movimentacoes_estoque', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('inventarios',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('itens_inventario', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}
