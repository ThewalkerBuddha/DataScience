# Build a complex app with complex features


class GenderApp(object):
    def __init__(self):
        names_sample = nltk.corpus.names
        self.names = [(name.lower(), 'male') for name in names_sample.words('male.txt')] + [(name.lower(), 'female')
                                                                         for name in names_sample.words('female.txt')]
        random.shuffle(self.names)

    @staticmethod
    def gender_features_cmplx(word):
        name = word.lower()  # normalise 
        features = {}#dict()
        features['first_letter'] = name[0] # get first letter
        features['last_letter'] = name[-1] # get last letter 
        for letter in 'abcdefghijklmnopqrstuvwxyz':
            features['count' + letter] = name.count(letter)
            # how many times each letter occurs in a name
            features['has' + letter] = letter in name 
            # sam --> 
            # counta = 1 and hasa = true and 
            # countb = 0 and hasb = false 
            # ea of this becomes a feature
        return features


if __name__ == '__main__':
    app = GenderApp()
    print(GenderApp.gender_features_cmplx('Sam'))






if __name__ == '__main__':
    app = GenderApp()
    for key,val  in GenderApp.gender_features_cmplx('Sam').items():
        print(key,'\t',val)







#[(GenderApp.gender_features_cmplx(name), gender) for name, gender in names]







#***
class GenderApp(object):
    def __init__(self):
        names_sample = nltk.corpus.names
        self.names = [(name.lower(), 'male') for name in names_sample.words('male.txt')] + [(name.lower(), 'female')
                                                                         for name in names_sample.words('female.txt')]
        random.shuffle(self.names)
        self.feature_sets = [(GenderApp.gender_features_cmplx(name), gender) for name, gender in self.names]
        self.train_set = self.feature_sets[:4000]
        self.test_set = self.feature_sets[4000:]
        self.classifier = nltk.NaiveBayesClassifier.train(self.train_set)

    def check_gender(self, name):
        name = name.lower()
        print('Gender for ' + name + ' : ' + self.classifier.classify(GenderApp.gender_features_cmplx(name)))

    @staticmethod
    def gender_features_cmplx(word):
        name = word.lower()  # let's normalise our input
        features = {}#dict()
        features['first_letter'] = name[0]
        features['last_letter'] = name[-1]
        for letter in 'abcdefghijklmnopqrstuvwxyz':
            features['count' + letter] = name.count(letter)
            features['has' + letter] = letter in name 
            # sam --> counta = 1 and hasa = true and hasb = false 
            # ea of this becomes a feature
        return features


if __name__ == '__main__':
    app = GenderApp()
    app.check_gender('Sam')
    app.check_gender('Samy')


















#***
class GenderApp(object):
    def __init__(self):
        names_sample = nltk.corpus.names
        self.names = [(name.lower(), 'male') for name in names_sample.words('male.txt')] + [(name.lower(), 'female')
                                                                         for name in names_sample.words('female.txt')]
        random.shuffle(self.names)
        self.feature_sets = [(GenderApp.gender_features_cmplx(name), gender) for name, gender in self.names]
        self.train_set = self.feature_sets[:4000]
        self.test_set = self.feature_sets[4000:]
        self.classifier = nltk.NaiveBayesClassifier.train(self.train_set)

    @staticmethod
    def gender_features_cmplx(word):
        name = word.lower()  # let's normalise our input
        features = {}#dict()
        features['first_letter'] = name[0]
        features['last_letter'] = name[-1]
        for letter in 'abcdefghijklmnopqrstuvwxyz':
            features['count' + letter] = name.count(letter)
            features['has' + letter] = letter in name 
            # sam --> counta = 1 and hasa = true and hasb = false 
            # ea of this becomes a feature
        return features

    def check_gender(self, name):
        name = name.lower()
        print('Gender for ' + name + ' : ' + self.classifier.classify(GenderApp.gender_features_cmplx(name)))

    def check_accuracy_of_the_classifier(self):
        print('Accuracy of classifier is : ', nltk.classify.accuracy(self.classifier, self.test_set) * 100)

    def show_most_informative_features(self, n=10):
        self.classifier.show_most_informative_features(n)

if __name__ == '__main__':
    app = GenderApp()
    app.check_gender('Neo')
    app.show_most_informative_features(20)
    app.check_accuracy_of_the_classifier()


