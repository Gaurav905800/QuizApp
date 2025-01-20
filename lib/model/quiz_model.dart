class QuizModel {
  int? id;
  Null name;
  String? title;
  String? description;
  Null difficultyLevel;
  String? topic;
  String? time;
  bool? isPublished;
  String? createdAt;
  String? updatedAt;
  int? duration;
  String? endTime;
  String? negativeMarks;
  String? correctAnswerMarks;
  bool? shuffle;
  bool? showAnswers;
  bool? lockSolutions;
  bool? isForm;
  bool? showMasteryOption;
  Null readingMaterial;
  Null quizType;
  bool? isCustom;
  Null bannerId;
  Null examId;
  bool? showUnanswered;
  String? endsAt;
  Null lives;
  String? liveCount;
  int? coinCount;
  int? questionsCount;
  String? dailyDate;
  int? maxMistakeCount;
  List<Null>? readingMaterials;
  List<Questions>? questions;
  int? progress;

  QuizModel(
      {this.id,
      this.name,
      this.title,
      this.description,
      this.difficultyLevel,
      this.topic,
      this.time,
      this.isPublished,
      this.createdAt,
      this.updatedAt,
      this.duration,
      this.endTime,
      this.negativeMarks,
      this.correctAnswerMarks,
      this.shuffle,
      this.showAnswers,
      this.lockSolutions,
      this.isForm,
      this.showMasteryOption,
      this.readingMaterial,
      this.quizType,
      this.isCustom,
      this.bannerId,
      this.examId,
      this.showUnanswered,
      this.endsAt,
      this.lives,
      this.liveCount,
      this.coinCount,
      this.questionsCount,
      this.dailyDate,
      this.maxMistakeCount,
      this.readingMaterials,
      this.questions,
      this.progress});

  QuizModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    description = json['description'];
    difficultyLevel = json['difficulty_level'];
    topic = json['topic'];
    time = json['time'];
    isPublished = json['is_published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    duration = json['duration'];
    endTime = json['end_time'];
    negativeMarks = json['negative_marks'];
    correctAnswerMarks = json['correct_answer_marks'];
    shuffle = json['shuffle'];
    showAnswers = json['show_answers'];
    lockSolutions = json['lock_solutions'];
    isForm = json['is_form'];
    showMasteryOption = json['show_mastery_option'];
    readingMaterial = json['reading_material'];
    quizType = json['quiz_type'];
    isCustom = json['is_custom'];
    bannerId = json['banner_id'];
    examId = json['exam_id'];
    showUnanswered = json['show_unanswered'];
    endsAt = json['ends_at'];
    lives = json['lives'];
    liveCount = json['live_count'];
    coinCount = json['coin_count'];
    questionsCount = json['questions_count'];
    dailyDate = json['daily_date'];
    maxMistakeCount = json['max_mistake_count'];
    if (json['reading_materials'] != null) {
      readingMaterials = [];
      json['reading_materials'].forEach((v) {
        readingMaterials!
            .add(ReadingMaterial.fromJson(v) as Null); // Correct class
      });
    }

    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['title'] = title;
    data['description'] = description;
    data['difficulty_level'] = difficultyLevel;
    data['topic'] = topic;
    data['time'] = time;
    data['is_published'] = isPublished;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['duration'] = duration;
    data['end_time'] = endTime;
    data['negative_marks'] = negativeMarks;
    data['correct_answer_marks'] = correctAnswerMarks;
    data['shuffle'] = shuffle;
    data['show_answers'] = showAnswers;
    data['lock_solutions'] = lockSolutions;
    data['is_form'] = isForm;
    data['show_mastery_option'] = showMasteryOption;
    data['reading_material'] = readingMaterial;
    data['quiz_type'] = quizType;
    data['is_custom'] = isCustom;
    data['banner_id'] = bannerId;
    data['exam_id'] = examId;
    data['show_unanswered'] = showUnanswered;
    data['ends_at'] = endsAt;
    data['lives'] = lives;
    data['live_count'] = liveCount;
    data['coin_count'] = coinCount;
    data['questions_count'] = questionsCount;
    data['daily_date'] = dailyDate;
    data['max_mistake_count'] = maxMistakeCount;
    data['questions'] = questions?.map((v) => v.toJson()).toList();
    data['progress'] = progress;
    return data;
  }
}

class Questions {
  int? id;
  String? description;
  Null difficultyLevel;
  String? topic;
  bool? isPublished;
  String? createdAt;
  String? updatedAt;
  String? detailedSolution;
  String? type;
  bool? isMandatory;
  bool? showInFeed;
  String? pyqLabel;
  int? topicId;
  int? readingMaterialId;
  String? fixedAt;
  String? fixSummary;
  Null createdBy;
  String? updatedBy;
  Null quizLevel;
  String? questionFrom;
  Null language;
  Null photoUrl;
  Null photoSolutionUrl;
  bool? isSaved;
  String? tag;
  List<Options>? options;
  ReadingMaterial? readingMaterial;

  Questions(
      {this.id,
      this.description,
      this.difficultyLevel,
      this.topic,
      this.isPublished,
      this.createdAt,
      this.updatedAt,
      this.detailedSolution,
      this.type,
      this.isMandatory,
      this.showInFeed,
      this.pyqLabel,
      this.topicId,
      this.readingMaterialId,
      this.fixedAt,
      this.fixSummary,
      this.createdBy,
      this.updatedBy,
      this.quizLevel,
      this.questionFrom,
      this.language,
      this.photoUrl,
      this.photoSolutionUrl,
      this.isSaved,
      this.tag,
      this.options,
      this.readingMaterial});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    difficultyLevel = json['difficulty_level'];
    topic = json['topic'];
    isPublished = json['is_published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    detailedSolution = json['detailed_solution'];
    type = json['type'];
    isMandatory = json['is_mandatory'];
    showInFeed = json['show_in_feed'];
    pyqLabel = json['pyq_label'];
    topicId = json['topic_id'];
    readingMaterialId = json['reading_material_id'];
    fixedAt = json['fixed_at'];
    fixSummary = json['fix_summary'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    quizLevel = json['quiz_level'];
    questionFrom = json['question_from'];
    language = json['language'];
    photoUrl = json['photo_url'];
    photoSolutionUrl = json['photo_solution_url'];
    isSaved = json['is_saved'];
    tag = json['tag'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    readingMaterial = json['reading_material'] != null
        ? ReadingMaterial.fromJson(json['reading_material'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['difficulty_level'] = difficultyLevel;
    data['topic'] = topic;
    data['is_published'] = isPublished;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['detailed_solution'] = detailedSolution;
    data['type'] = type;
    data['is_mandatory'] = isMandatory;
    data['show_in_feed'] = showInFeed;
    data['pyq_label'] = pyqLabel;
    data['topic_id'] = topicId;
    data['reading_material_id'] = readingMaterialId;
    data['fixed_at'] = fixedAt;
    data['fix_summary'] = fixSummary;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['quiz_level'] = quizLevel;
    data['question_from'] = questionFrom;
    data['language'] = language;
    data['photo_url'] = photoUrl;
    data['photo_solution_url'] = photoSolutionUrl;
    data['is_saved'] = isSaved;
    data['tag'] = tag;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (readingMaterial != null) {
      data['reading_material'] = readingMaterial!.toJson();
    }
    return data;
  }
}

class Options {
  int? id;
  String? description;
  int? questionId;
  bool? isCorrect;
  String? createdAt;
  String? updatedAt;
  bool? unanswered;
  Null photoUrl;

  Options(
      {this.id,
      this.description,
      this.questionId,
      this.isCorrect,
      this.createdAt,
      this.updatedAt,
      this.unanswered,
      this.photoUrl});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    questionId = json['question_id'];
    isCorrect = json['is_correct'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    unanswered = json['unanswered'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['question_id'] = questionId;
    data['is_correct'] = isCorrect;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['unanswered'] = unanswered;
    data['photo_url'] = photoUrl;
    return data;
  }
}

class ReadingMaterial {
  int? id;
  String? keywords;
  Null content;
  String? createdAt;
  String? updatedAt;
  List<String>? contentSections;
  PracticeMaterial? practiceMaterial;

  ReadingMaterial(
      {this.id,
      this.keywords,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.contentSections,
      this.practiceMaterial});

  ReadingMaterial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keywords = json['keywords'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentSections = json['content_sections'].cast<String>();
    practiceMaterial = json['practice_material'] != null
        ? PracticeMaterial.fromJson(json['practice_material'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['keywords'] = keywords;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['content_sections'] = contentSections;
    if (practiceMaterial != null) {
      data['practice_material'] = practiceMaterial!.toJson();
    }
    return data;
  }
}

class PracticeMaterial {
  List<String>? content;
  List<String>? keywords;

  PracticeMaterial({this.content, this.keywords});

  PracticeMaterial.fromJson(Map<String, dynamic> json) {
    content = json['content'].cast<String>();
    keywords = json['keywords'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['keywords'] = keywords;
    return data;
  }
}
